<?php

namespace App\Controller;

use App\Entity\User;
use App\Form\UserType;
use App\Entity\ResetPassword;
use App\Repository\UserRepository;
use Doctrine\ORM\EntityManagerInterface;
use App\Repository\ResetPasswordRepository;
use Symfony\Bridge\Twig\Mime\TemplatedEmail;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Validator\Constraints\Length;
use Symfony\Component\Validator\Constraints\NotBlank;
use Symfony\Component\Form\Extension\Core\Type\EmailType;
use Symfony\Component\Form\Extension\Core\Type\PasswordType;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Security\Http\Authentication\AuthenticationUtils;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\RateLimiter\RateLimiterFactory;
use Symfony\Component\Security\Http\Authenticator\FormLoginAuthenticator;
use Symfony\Component\Security\Http\Authentication\UserAuthenticatorInterface;


class AuthController extends AbstractController
{
    public function __construct(
        private FormLoginAuthenticator $authenticator
    ) {
    }

    #[Route('/inscription', name: 'inscription')]
    public function inscription(Request $request, EntityManagerInterface $em, UserPasswordHasherInterface $passwordHasher, UserAuthenticatorInterface $userAuthenticatorInterface, MailerInterface $mailerInterface): Response
    {
        $user = new User();
        $userForm = $this->createForm(UserType::class, $user);
        $userForm->handleRequest($request);

        if ($userForm->isSubmitted() && $userForm->isValid()) {
            $hash = $passwordHasher->hashPassword($user, $user->getPassword());
            $user->setPassword($hash);
            $em->persist($user);
            $em->flush();
            $this->addFlash('success', 'Bienvenue sur Wonder !');

            $email = new TemplatedEmail();
            $email->to($user->getEmail())
                ->subject('Bienvenue sur Wonder')
                ->htmlTemplate('@email_templates/welcome.html.twig')
                ->context([
                    'username' => $user->getFirstname()
                ]);
            $mailerInterface->send($email);

            return $userAuthenticatorInterface->authenticateUser($user, $this->authenticator, $request);
        }

        return $this->render('auth/inscription.html.twig', [
            'form' => $userForm->createView(),
        ]);
    }

    #[Route('/login', name: 'login')]
    public function login(AuthenticationUtils $authenticationUtils): Response
    {
        if ($this->getUser()) {
            return $this->redirectToRoute('home');
        }
        $error = $authenticationUtils->getLastAuthenticationError();
        $lastUsername = $authenticationUtils->getLastUsername();

        return $this->render('auth/login.html.twig', [
            'error' => $error,
            'last_username' => $lastUsername
        ]);
    }
    #[Route('/logout', name: 'logout')]
    public function logout()
    {
    }

    #[Route('/reset-password/{token}', name: 'reset-password')]
    public function resetPassword(RateLimiterFactory $passwordRecoveryLimiter,string $token, EntityManagerInterface $em, UserPasswordHasherInterface $userPasswordHasher, Request $request, ResetPasswordRepository $resetPasswordRepository): Response
    {
        $limiter = $passwordRecoveryLimiter->create($request->getClientIp());
        if(false === $limiter->consume(1)->isAccepted()){
            $this->addFlash('error','Vous devez attendre une heure pour refaire une récupération');
            return $this->redirectToRoute('login');
        }

        $resetPassword = $resetPasswordRepository->findOneBy(['token' => sha1($token)]);
        if (!$resetPassword || $resetPassword->getExpiredAt() < new \DateTime('now')) {
            if ($resetPassword) {
                $em->remove($resetPassword);
                $em->flush();
            }
            $this->addFlash('error', 'Votre demande est expirée veuillez refaire une demande');
            return $this->redirectToRoute('login');
        }
        $passwordForm = $this->createFormBuilder()->add('password', PasswordType::class, [
            'label' => 'Nouveau mot de passe',
            'constraints' => [
                new Length([
                    'min' => 6,
                    'minMessage' => 'Le mot de passe doit faire au moins 6 caractères'
                ]),
                new NotBlank([
                    'message' => 'Veuillez renseigner un mot de passe'
                ])
            ]
        ])->getForm();

        $passwordForm->handleRequest($request);
        if($passwordForm->isSubmitted() && $passwordForm->isValid()){
            $password = $passwordForm->get('password')->getData();
            $user = $resetPassword->getUser();
            $hash = $userPasswordHasher->hashPassword($user, $password);
            $user->setPassword($hash);
            $em->remove($resetPassword);
            $em->flush();
            $this->addFlash('success','Votre mot de passe a été modifié');
            return $this->redirectToRoute('login');
        }
        return $this->render('auth/reset_password_form.html.twig',[
            'form'=>$passwordForm->createView()
        ]);
    }

    #[Route('/reset-password-request', name: 'reset-password-request')]
    public function resetPasswordRequest(RateLimiterFactory $passwordRecoveryLimiter,MailerInterface $mailerInterface, EntityManagerInterface $em, Request $request, UserRepository $userRepository, ResetPasswordRepository $resetPasswordRepository): Response
    {
        $limiter = $passwordRecoveryLimiter->create($request->getClientIp());
        if (false === $limiter->consume(1)->isAccepted()) {
            $this->addFlash('error', 'Vous devez attendre une heure pour refaire une récupération');
            return $this->redirectToRoute('login');
        }

        $emailForm = $this->createFormBuilder()->add('email', EmailType::class, [
            'constraints' => [new NotBlank(['message' => 'Veuillez renseigner votre email'])]
        ])->getForm();

        $emailForm->handleRequest($request);
        if ($emailForm->isSubmitted() && $emailForm->isValid()) {
            $emailValue = $emailForm->get('email')->getData();
            $user = $userRepository->findOneBy(['email' => $emailValue]);
            if ($user) {
                $oldResetPassword = $resetPasswordRepository->findOneBy(['user' => $user]);
                if ($oldResetPassword) {
                    $em->remove($oldResetPassword);
                    $em->flush();
                }
                $resetPassword = new ResetPassword();
                $resetPassword->setUser($user)
                    ->setExpiredAt(new \DateTimeImmutable('+ 2 hours'));
                $token = substr(str_replace(['+', '/', '='], '', base64_encode(random_bytes(30))), 0, 20);
                $hash= sha1($token);
                $resetPassword->setToken($hash);

                $em->persist($resetPassword);
                $em->flush();

                $email = new TemplatedEmail();
                $email->to($emailValue)
                    ->subject('Demande de réinitialisation de mot de passe')
                    ->htmlTemplate('@email_templates/reset_password_request.html.twig')
                    ->context(['token' => $token]);

                $mailerInterface->send($email);
            }
            $this->addFlash('success', 'Un email vous a été envoyé pour réinitialiser votre mot de passe');
            return $this->redirectToRoute('home');
        }
        return $this->render('auth/reset_password_request.html.twig', [
            'form' => $emailForm->createView()
        ]);
    }
}
