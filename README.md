# but du repo

Ce repository regroupe tous les containers des applications tierces utilisées 
dans l'application __Signaux Faibles__  
exemple : wekan, keycloak etc etc.

Les conteneurs contenant les applications développées par 
l'équipe de __Signaux Faibles__ sont dans leur repository Github respectifs

# fonctionnement

Chaque répertoire contient le fichier `Dockerfile` permettant de construire le conteneur.
C'est dans ce fichier que l'on fixe le numéro de version souhaité.
A l'installation, on utilisera la version`latest` de chaque conteneur.

# workflow

Il y a un [fichier de worflow commun](.github/workflows/build-3rd-app-and-publish.yml) à tous qui construit le 
conteneur et le pousse dans le registre correspondant.
Les autres fichiers de workflow se lancent uniquement lorsqu'une modification est faite
sur le répertoire correspondant.
Ex : si je modifie un fichier dans le répertoire `Gollum`, 
c'est [le workflow de Gollum](.github/workflows/publish-gollum.yml) qui démarrera.

Cependant chaque workflow peut être lancé manuellement via 
[l'interface de `Github`](https://github.com/signaux-faibles/conteneurs/actions)

__ATTENTION : cette façon présente l'inconvénient de ne pas 
fonctionner localement avec [`act`](https://github.com/nektos/act)__  

_NB : les fichiers de builds `build.sh` et `.gitignore` sont voués à disparaître._


