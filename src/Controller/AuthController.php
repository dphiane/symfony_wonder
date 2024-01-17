<?php

namespace App\Controller;

use App\Form\UserType;
use App\Entity\User;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Authentication\AuthenticationUtils;
use Symfony\Component\Security\Http\Authentication\UserAuthenticatorInterface;
use Symfony\Component\Security\Http\Authenticator\FormLoginAuthenticator;

class AuthController extends AbstractController
{
    public function __construct(
        private FormLoginAuthenticator $authenticator
    ) {
    }

    #[Route('/inscription', name: 'inscription')]
    public function inscription(Request $request, EntityManagerInterface $em, UserPasswordHasherInterface $passwordHasher,UserAuthenticatorInterface $userAuthenticatorInterface): Response
    {
        $user=new User();
        $userForm=$this->createForm(UserType::class,$user);
        $userForm->handleRequest($request);

        if($userForm->isSubmitted() && $userForm->isValid()){
            $hash= $passwordHasher->hashPassword($user,$user->getPassword());
            $user->setPassword($hash);
            $em->persist($user);
            $em->flush();
            $this->addFlash('success','Bienvenue sur Wonder !');
            return $userAuthenticatorInterface->authenticateUser($user,$this->authenticator,$request);
        }

        return $this->render('auth/inscription.html.twig', [
            'form' => $userForm->createView()
        ]);
    }

    #[Route('/login', name: 'login')]
    public function login(AuthenticationUtils $authenticationUtils): Response
    {
        if($this->getUser()){
            return $this->redirectToRoute('home');
        }
        $error= $authenticationUtils->getLastAuthenticationError();
        $lastUsername= $authenticationUtils->getLastUsername();

        return $this->render('auth/login.html.twig', [
            'error'=> $error,
            'last_username'=> $lastUsername
        ]);
    }
    #[Route('/logout', name: 'logout')]
    public function logout()
    {

    }
}
