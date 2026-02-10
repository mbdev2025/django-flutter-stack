from django.db import models


class BaseModel(models.Model):
    """
    Modèle abstrait de base avec timestamps.
    Tous les modèles de l'application devraient hériter de cette classe.
    """
    created_at = models.DateTimeField(auto_now_add=True, verbose_name="Date de création")
    updated_at = models.DateTimeField(auto_now=True, verbose_name="Date de modification")
    
    class Meta:
        abstract = True
        ordering = ['-created_at']
