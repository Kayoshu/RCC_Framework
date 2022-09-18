# RCC_Framework


Paramètres au lobby:
* ancien choix du nombre de vies: 1, 3, 5, 10, 100
* nouveau: démarrer en illimité -> les vies ne sont pas décomptées à la mort (module pour basculer à tout moment ingame)
* nouveau "safestart" -> les balles/grenades sont interceptées et ne font aucun dégats (pour préserver un joli décor du GM des maladroits), il y a un nouveau module pour désactiver/activer  le "safestart" à tout moment ingame

![image](https://user-images.githubusercontent.com/113190714/190918356-10c6d7ad-314d-4b18-9757-0dbe5e88c47c.png)


Modules zeus:
* AI Set Manual Dismount -> crée une action pour zeus sur un helicopter qui permet de faire descendre les squad AI à l'intérieur (zeus remote control le pilote)
* AI Set Vehicle Driver -> crée une action sur un véhicule pour que les joueurs puissent créer eux memes un pilote AI
* Un-Garrison (enable PATH) -> reactive le path d'une AI, si clic sur le leader, cela s'active pour tout le groupe, si pas leader, nouveau groupe créé avec juste cette unité qui cherche la sortie de building la plus proche

* Fog Low/ Fog RIng: script d'alias cartoon pour créer les zones de fog (low pour des cuvettes, ring pour une anneau sur du relief)

* Add ACE medical -> fonctionne maintenant comme le module munitions, s'utilise sur un vehicule ou une caisse, permet d'ajuster les quantités médicales ajoutées
* Add Players Ammunitions -> meme chose pour les munitions selon ce que les joueurs ont dans leur inventaire

* Custom ending -> si le menu est ouvert par un zeus, cela bloque l'ouverture pour un zeus assistant, et éviter d'ecraser mutuellement le texte sauvegardé
* Fade Music -> inchangé
* Transition -> 4 textes seulement, avec possibilité d'envoyer le texte uniquement sur une side
* Transition Time -> 2 zones de textes avec un changement de date/heure au milieu

* Add Tickets to all alive players -> ajoute X vies a tous les joueurs VIVANTS
* List Dead & Spectators -> affiche une liste des joueurs en mort et/ou en spectateur, case à cocher pour leur ajouter une vie et les sortir de spec (nouveauté quand un joueur est en spec il devient civil -> plus visible d'identifier les morts pour le zeus)
*Modify Individual tickets -> liste les joueurs vivants, et modife leurs vies
* Set all alive players Tickets -> mets tous les joueurs vivants à X vies
* Toggle Tickets Respawn -> permet de basculer vies limitées ou illimitées 

* Check Mods -> module debug pour lister des mods problématiques (inutile actuellement)
* Force delete -> supprimer un objet récalcitrant (certains mods/scripts)
* Group Cap Reset -> remise à zero de la limite de groupes (quand ne pouvez plus spawn d'unités)
* Safe start -> permet de basculer la nouveauté "safestart" à tout moment
* Toggle consciousness -> bascule le coma on/off sur un joueur ou IA

![image](https://user-images.githubusercontent.com/113190714/190918412-68b4e63c-9665-422e-afb5-717bcb2776f2.png)


Actions au clic droit sur joueur:
* Toggle consciousness: meme chose que le module précédent
* Teleport to squadmate, ouvre un menu avec les membres du squad du joueur et le téléporte sur la sélection
* Modifiy lives -> comme le module permet de modifier les vies sur un joueur individuel 

![image](https://user-images.githubusercontent.com/113190714/190918435-ab843c58-38a4-4702-8439-e64e4b241740.png)
