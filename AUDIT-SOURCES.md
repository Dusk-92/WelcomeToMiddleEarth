# Sources et limites de validation

Ce fichier documente les hypothèses utilisées par la maintenance communautaire de WelcomeToMiddleEarth.

## API Lua LOTRO

Les points suivants sont traités comme des invariants de l'API :

- l'objet temporaire global `plugin` référence le plugin pendant son chargement et permet d'enregistrer `plugin.Unload` ;
- `Turbine.PluginData.Save(scope, key, data, callback)` accepte un callback dont les arguments sont `succeeded` et `message` ;
- un `Configuration Apartment` dédié isole l'environnement Lua du plugin et facilite son déchargement indépendant.

Références de travail :
- documentation communautaire de l'API Lua LOTRO ;
- discussions techniques LoTROInterface sur `plugin.Unload`, les Apartments et PluginData.

## Progression et données de jeu

- Les noms, icônes et descriptions de compétences sont lus directement depuis le client LOTRO.
- Les niveaux de compétences de classe utilisés comme filtre de progression restent une table de référence maintenue manuellement dans `Progression.lua`.
- Les gambits de Sentinelle sont lus séparément via les attributs de classe.
- Le calendrier historique des points de trait conservé dans l'addon s'arrête au niveau 140 ; il n'est pas extrapolé automatiquement au-delà.
- Les jalons 140, 150 et 160 servent uniquement de messages de progression et ne remplacent pas les prérequis réellement appliqués par le jeu.

## Limites

Une refonte de classe LOTRO peut modifier les niveaux d'acquisition de compétences. Dans ce cas, la table `levelLists` de `Progression.lua` doit être revue.

Le validateur automatique vérifie la structure du dépôt, les namespaces, les traductions, les images et la syntaxe Lua. Il ne peut pas certifier les données de gameplay sans contrôle en jeu.
