# projetfinal

A new Flutter project.
Voici une documentation pour votre application, incluant un guide d'utilisation et une présentation des fonctionnalités.

# Documentation de l'application

## Introduction

Cette application est conçue pour gérer les dépenses personnelles des utilisateurs. Elle permet aux utilisateurs de se connecter, de s'inscrire, de visualiser leurs dépenses par catégorie, et d'ajouter ou de modifier des transactions. L'application utilise Firebase pour l'authentification et le stockage des données.

## Guide d'utilisation

### 1. Authentification

#### Page de connexion (LoginPage)

- *Fonctionnalités* : Permet aux utilisateurs de se connecter avec leur adresse e-mail et mot de passe.
- *Composants* :
  - *Champs de saisie* : E-mail, Mot de passe.
  - *Bouton* : "Sign In" pour soumettre les informations.
  - *Lien* : "Forgot Password?" pour récupérer un mot de passe oublié.
  - *Options de connexion* : Authentification via Google ou Apple.

#### Page d'inscription (RegisterPage)

- *Fonctionnalités* : Permet aux nouveaux utilisateurs de créer un compte.
- *Composants* :
  - *Champs de saisie* : E-mail, Mot de passe, Confirmation du mot de passe.
  - *Bouton* : "Sign Up" pour soumettre les informations.

### 2. Navigation

#### Page d'authentification (AuthPage)

- *Fonctionnalités* : Vérifie si un utilisateur est connecté ou non.
- *Comportement* : Redirige vers la page d'accueil (Homepage) si l'utilisateur est connecté, ou vers la page de connexion/inscription (LoginOrRegisterPage) si non.

### 3. Gestion des Dépenses

#### Page d'accueil (Homepage)

- *Fonctionnalités* : Affiche les dépenses de l'utilisateur et permet d'ajouter de nouvelles dépenses.
- *Composants* :
  - *Graphique* : Représentation des dépenses hebdomadaires.
  - *Liste des dépenses* : Affiche les dépenses avec des options pour modifier ou supprimer.
  - *Bouton flottant* : Pour ajouter une nouvelle dépense.

#### Page des catégories de dépenses (CategoryExpenses)

- *Fonctionnalités* : Affiche les dépenses organisées par catégorie.
- *Composants* :
  - *Total des dépenses* : Montant total des dépenses affiché en haut.
  - *Liste des catégories* : Affiche chaque catégorie avec le total des dépenses.

### 4. Paramètres

#### Page des paramètres (SettingPage)

- *Fonctionnalités* : Permet à l'utilisateur de changer le mode de thème (clair/sombre) et d'envoyer des notifications.
- *Composants* :
  - *Bouton de changement de thème* : Permet de basculer entre les modes clair et sombre.
  - *Bouton d'envoi de notification* : Envoie une notification à l'utilisateur.

### 5. Notifications

#### Service de notification (NotifService)

- *Fonctionnalités* : Gère l'envoi de notifications locales.
- *Méthodes* :
  - initNotification() : Initialise le service de notification.
  - showNotification() : Affiche une notification avec un titre et un corps spécifiés.

## Présentation des fonctionnalités

### Authentification

- *Connexion sécurisée* : Utilisation de Firebase pour l'authentification des utilisateurs.
- *Inscription facile* : Créez un compte en quelques étapes simples.

### Gestion des Dépenses

- *Ajout et suppression* : Ajoutez de nouvelles dépenses et supprimez celles qui ne sont plus nécessaires.
- *Visualisation par catégorie* : Analysez vos dépenses par catégorie pour mieux gérer votre budget.

### Notifications

- *Alertes personnalisées* : Recevez des notifications pour des événements importants liés à vos dépenses.

### Interface Utilisateur

- *Design intuitif* : Interface conviviale avec une navigation fluide.
- *Thème personnalisable* : Choisissez entre un mode clair ou sombre selon vos préférences.

## Conclusion

Cette application de gestion des dépenses personnelles offre une solution complète pour suivre vos finances. Grâce à une interface intuitive et des fonctionnalités robustes, elle vous aide à gérer vos dépenses de manière efficace. Pour toute question ou problème, n'hésitez pas à consulter les développeurs ou la documentation supplémentaire.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
