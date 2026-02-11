from django.contrib import admin
from django.urls import path, include
from django.http import HttpResponse
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
)

# Vue de test pour valider que le serveur répond correctement
def home_test(request):
    return HttpResponse("""
        <body style='font-family: sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; background: #f0f2f5;'>
            <div style='text-align: center; padding: 50px; background: white; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.1);'>
                <h1 style='color: #2e7d32;'>✅ Stack Operationnelle !</h1>
                <p style='color: #666;'>Django + Wagtail + JWT API sont prêts pour Flutter.</p>
                <div style='margin-top: 20px;'>
                    <a href='/admin/' style='color: #1976d2; text-decoration: none;'>Accéder à Django Admin</a> | 
                    <a href='/cms/' style='color: #1976d2; text-decoration: none;'>Accéder à Wagtail CMS</a>
                </div>
            </div>
        </body>
    """)

# Une seule définition de urlpatterns pour éviter les écrasements
urlpatterns = [
    # 1. Racine : Test de fonctionnement
    path('', home_test, name='home'), 
    
    # 2. Interface Django Admin standard
    path('admin/', admin.site.urls), 
    
    # 3. CMS Wagtail (Administration et Documents)
    path('cms/', include('wagtail.admin.urls')),
    path('documents/', include('wagtail.documents.urls')),
    path('pages/', include('wagtail.urls')), 
    
    # 4. API Endpoints pour l'application mobile Flutter
    path('api/v1/token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/v1/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
]