# 🚀 Django + Flutter Stack (Omni-Channel Edition)

> **Template réutilisable pour développer des Applications Mobiles avec un Backend Django robuste.**

---

## 🛠️ Stack Technique

### Backend (API Mobile First)
- **Django 5.1.15** : Framework robuste et sécurisé.
- **Django REST Framework 3.16.1** : Pour l'API.
- **JWT Auth 5.5.1** : Authentification sécurisée pour le mobile.
- **Swagger / OpenAPI 0.29.0** : Documentation interactive (`/api/docs/`).
- **CORS Headers 4.9.0** : Prêt pour Flutter.

### Mobile (Frontend)
- **Flutter 3.2+** : UI multiplateforme.
- **Riverpod 2.6.1** : Gestion d'état performante.
- **Dio 5.7.0** : Client HTTP optimisé.
- **GoRouter 14.6.2** : Navigation déclarative.
- **Secure Storage 9.2.2** : Stockage sécurisé des tokens.

---

## 🚀 Démarrage Rapide

### 1. Cloner le template
```bash
git clone https://github.com/votre-user/django-flutter-stack.git
cd django-flutter-stack
```

### 2. Initialisation automatique
```bash
python3 scripts/setup_project.py
```

### 3. Lancer le backend
```bash
cd backend
source venv/bin/activate
python manage.py runserver
```

### 4. Lancer le mobile
```bash
cd mobile
flutter pub get
flutter run
```

---

## 🗺️ Guide des Endpoints

| Service | URL | Description |
| :--- | :--- | :--- |
| **🏠 Admin** | `/admin/` | Gestion technique. |
| **📚 API Docs** | `/api/docs/` | Swagger interactif. |
| **🔑 Auth Login** | `/api/token/` | Obtenir les tokens JWT. |
| **🔑 Auth Register** | `/api/auth/register/` | Créer un compte. |
| **👤 Profile** | `/api/auth/profile/` | Profil utilisateur. |

---

## ⚙️ Configuration (.env)

Copiez `.env.example` vers `.env` pour configurer :
- `SECRET_KEY`
- `DEBUG`
- `ALLOWED_HOSTS`

---

## 🤝 Contribution
Maintenu par **Antigravity**. 🚀
