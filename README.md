Bonjour,

Voici ma première web application symfony.
Il s'agit d'une imitation du site Quora.

Projet guidé en Symfony
Page de présentation des questions
Page de détails des questions
Page de création des questions
Système de commentaires / réponses avec validation des questions
Possibilité de voter pour la pertinence des réponses
Utilisation du bundle KnpTime
Système d’authentification (inscription / connexion)
Réinitialisation du mot de passe
Confirmation par mail d’inscription
Page de profil avec photo
Installation de WebpackEncore
Barre de recherche avec Vue js

Installation:

télécharger le projet ou utilisé git clone https://github.com/dphiane/symfony_wonder.git
utiliser les commandes:
-composer install
-npm install ou yarn install
npm run build ou yarn run build

vous devrez ensuite configurer le fichier .env
décommenter la ligne suivante si vous utiliser une base de donnée MySQL, et remplacer les informations comme le nom d'utilisateur, le mot de passe, le nom du schemas.
# DATABASE_URL="mysql://app:!ChangeMe!@127.0.0.1:3306/app?serverVersion=8.0.32&charset=utf8mb4"
et commenté les autres lignes DATABASE_URL.

Décommenté la ligne # MAILER_DSN=null://null et inséré votre token mailer.
Cela devrais ressembler a cela:
MAILER_DSN=mailtrap+api://YOUR_API_KEY_HERE@default
# or
MAILER_DSN=mailtrap+api://YOUR_API_KEY_HERE@send.api.mailtrap.io
Vous pouvez utiliser le mailer Mailtrap qui est gratuit.

Vous pouvez ensuite lancer le serveur avec la commande: symfony serve -d
