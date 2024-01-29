<?php

namespace App\Form;

use App\Entity\User;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\FileType;
use Symfony\Component\Form\Extension\Core\Type\PasswordType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Validator\Constraints\Image;

class UserType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $user= $builder->getData();

        $builder
            ->add('email',null,['label'=>'Votre email'])
            ->add('firstname', null, ['label' =>'Votre prénom'])
            ->add('lastname',null,['label'=>'Votre Nom'])
            ->add('pictureFile',FileType::class,[
                'label'=> $user->getPicture() ? 'Ma photo profile': 'Ajouter une photo de profile',
                'mapped'=>false,
                'required'=> $user->getPicture() ? false : true,
                'constraints'=>[
                    new Image([
                        'mimeTypesMessage'=>'Veuillez soumettre une image',
                        'maxSize'=> '1M',
                        'maxSizeMessage'=>'Votre image fait {{ size }} {{ suffix }}.La limite est de {{ limit}} {{ suffix }}'
                    ])
                ]])
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
