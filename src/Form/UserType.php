<?php

namespace App\Form;

use App\Entity\User;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\PasswordType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class UserType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('email',null,['label'=>'Votre email'])
            ->add('firstname', null, ['label' =>'Votre prénom'])
            ->add('lastname',null,['label'=>'Votre Nom'])
            ->add('picture',null,['label'=>'Une photo de profile'])
            ->add('password',PasswordType::class,['label'=>'Votre mot de passe'])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => User::class,
        ]);
    }
}
