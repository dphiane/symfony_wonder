# Symfony Wonder

Bonjour,

Voici ma première web application Symfony. Il s'agit d'une imitation du site Quora.

## Fonctionnalités

- Projet guidé en Symfony
- Page de présentation des questions
- Page de détails des questions
- Page de création des questions
- Système de commentaires / réponses avec validation des questions
- Possibilité de voter pour la pertinence des réponses
- Utilisation du bundle KnpTime
- Système d’authentification (inscription / connexion)
- Réinitialisation du mot de passe
- Confirmation par mail d’inscription
- Page de profil avec photo
- Installation de WebpackEncore
- Barre de recherche avec Vue.js

## Installation

1. Téléchargez le projet ou utilisez `git clone https://github.com/dphiane/symfony_wonder.git`
2. Utilisez les commandes suivantes :
   - `composer install`
   - `npm install` ou `yarn install`
   - `npm run build` ou `yarn run build`
3. Configurez le fichier `.env` :
   - Décommentez la ligne suivante si vous utilisez une base de données MySQL, et remplacez les informations comme le nom d'utilisateur, le mot de passe, le nom du schéma :
     ```
     DATABASE_URL="mysql://app:!ChangeMe!@127.0.0.1:3306/app?serverVersion=8.0.32&charset=utf8mb4"
     ```
   - Commentez les autres lignes `DATABASE_URL`.
   - Décommentez la ligne `# MAILER_DSN=null://null` et insérez votre token mailer. Cela devrait ressembler à ceci :
     ```
     MAILER_DSN=mailtrap+api://YOUR_API_KEY_HERE@default
     ```
     ou
     ```
     MAILER_DSN=mailtrap+api://YOUR_API_KEY_HERE@send.api.mailtrap.io
     ```
   - Vous pouvez utiliser le mailer Mailtrap qui est gratuit.
     
4. Lancez le serveur avec la commande : symfony serve -d
