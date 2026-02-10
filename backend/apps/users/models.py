from django.contrib.auth.models import AbstractUser
from django.db import models


class User(AbstractUser):
    """
    Modèle utilisateur personnalisé pour l'application mobile.
    """
    phone = models.CharField(max_length=20, blank=True, null=True, verbose_name="Téléphone")
    avatar = models.FileField(upload_to='avatars/', blank=True, null=True, verbose_name="Avatar")
    bio = models.TextField(blank=True, null=True, verbose_name="Biographie")
    
    class Meta:
        verbose_name = "Utilisateur"
        verbose_name_plural = "Utilisateurs"
    
    def __str__(self):
        return self.email or self.username
