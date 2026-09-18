# WelcomeToMiddleEarth — maintenance communautaire

Cette version maintient l'addon **WelcomeToMiddleEarth** de Thardariel / Die Bewahrer Mittelerdes et l'installe sous l'espace de noms `Dusk`.

## Installation

Copier le dossier `Dusk` dans :

```text
Documents\The Lord of the Rings Online\Plugins\
```

Structure attendue :

```text
Plugins
└── Dusk
    ├── WelcomeToMiddleEarth.plugin
    └── WelcomeToMiddleEarth
        ├── Main.lua
        ├── Progression.lua
        ├── Strings.lua
        └── images
```

Recharge ensuite les plugins dans LOTRO puis charge **WelcomeToMiddleEarth** depuis le gestionnaire de plugins.

## Commandes

- `/wtme` : ouvre le suivi de progression.
- `/wtme levelup` : réaffiche le dernier gain de niveau mémorisé.
- `/wtme help` : ouvre le guide des objets légendaires.
- `/wtme diagnostic` : affiche l'état de lecture des compétences.

## Version

**1.4.17-community**

Cette version :
- utilise le namespace `Dusk.WelcomeToMiddleEarth` ;
- isole l'addon dans son propre Apartment LOTRO ;
- nettoie correctement ses callbacks et sa commande lors de l'Unload ;
- vérifie le résultat des sauvegardes PluginData via leur callback ;
- conserve les notifications de niveau, les sauts de plusieurs niveaux et les étapes illustrées ;
- propose l'interface en français, anglais et allemand.

## Attribution

Addon original : **Thardariel / Die Bewahrer Mittelerdes**.

Maintenance communautaire de ce dépôt : **Dusk-92**.

Aucune licence supplémentaire n'est déclarée ici pour le code ou les médias d'origine. Avant toute redistribution hors de ce dépôt, vérifier les droits applicables aux éléments hérités de la version originale.
