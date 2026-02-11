"""
Configuration Django complète pour la stack mobile hybride (Wagtail + DRF).
Optimisé pour Project IDX.
"""
import os
from pathlib import Path
from datetime import timedelta
from decouple import config

# Chemins de base
BASE_DIR = Path(__file__).resolve().parent.parent

# Sécurité & Debug
SECRET_KEY = config('SECRET_KEY', default='django-insecure-dev-key')
DEBUG = config('DEBUG', default=True, cast=bool)

# Autorisations pour IDX (permet l'affichage de la preview)
ALLOWED_HOSTS = ['*', '.idx.google.com', 'localhost', '127.0.0.1']

# Applications installées
INSTALLED_APPS = [
    # Core Django
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    
    # Wagtail CMS (Indispensable pour ton module CMS)
    'wagtail.contrib.forms',
    'wagtail.contrib.redirects',
    'wagtail.embeds',
    'wagtail.sites',
    'wagtail.users',
    'wagtail.snippets',
    'wagtail.documents',
    'wagtail.images',
    'wagtail.search',
    'wagtail.admin',
    'wagtail',
    'modelcluster',
    'taggit',

    # API & Mobile (Django Rest Framework)
    'rest_framework',
    'rest_framework_simplejwt',
    'drf_spectacular',
    'corsheaders',
    'django_filters',
    
    # Apps locales (Respect de ton arborescence)
    'apps.core',
    'apps.users',
]

# Middlewares (Ordre critique pour la sécurité et le mobile)

MIDDLEWARE = [
    'corsheaders.middleware.CorsMiddleware',
    'django.middleware.security.SecurityMiddleware',
    'whitenoise.middleware.WhiteNoiseMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'wagtail.contrib.redirects.middleware.RedirectMiddleware',
]

ROOT_URLCONF = 'config.urls'

# --- CORRECTION DE L'ERREUR admin.E403 ---
TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [BASE_DIR / 'templates'],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'config.wsgi.application'

# Base de données (Utilisation de SQLite par défaut pour le dev sur IDX)
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'db.sqlite3',
    }
}

# Modèle utilisateur personnalisé
AUTH_USER_MODEL = 'users.User'

# Configuration API (JWT & Documentation)
REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': ('rest_framework_simplejwt.authentication.JWTAuthentication',),
    'DEFAULT_PERMISSION_CLASSES': ('rest_framework.permissions.IsAuthenticated',),
    'DEFAULT_SCHEMA_CLASS': 'drf_spectacular.openapi.AutoSchema',
}

SIMPLE_JWT = {
    'ACCESS_TOKEN_LIFETIME': timedelta(minutes=60),
    'REFRESH_TOKEN_LIFETIME': timedelta(days=7),
    'ROTATE_REFRESH_TOKENS': True,
}

# --- RÉGLAGES SÉCURITÉ PROJECT IDX & MOBILE ---
CORS_ALLOW_ALL_ORIGINS = True  # Autorise ton app Flutter à parler à l'API
CSRF_TRUSTED_ORIGINS = [
    'https://*.idx.google.com',
    'http://localhost:8000',
    'http://127.0.0.1:8000',
]

# Configuration Wagtail
WAGTAIL_SITE_NAME = 'Mobile API CMS'
WAGTAILADMIN_BASE_URL = 'http://localhost:8000'

# Configuration Celery & Redis
CELERY_BROKER_URL = config('REDIS_URL', default='redis://localhost:6379/0')
CELERY_RESULT_BACKEND = config('REDIS_URL', default='redis://localhost:6379/0')

# Static & Media
STATIC_URL = '/static/'
STATIC_ROOT = BASE_DIR / 'staticfiles'
MEDIA_URL = '/media/'
MEDIA_ROOT = BASE_DIR / 'media'
DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'