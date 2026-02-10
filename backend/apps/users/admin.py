from django.contrib import admin
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin
from .models import User


@admin.register(User)
class UserAdmin(BaseUserAdmin):
    """
    Configuration de l'admin pour le modèle User personnalisé.
    """
    fieldsets = BaseUserAdmin.fieldsets + (
        ('Informations supplémentaires', {'fields': ('phone', 'avatar', 'bio')}),
    )
    add_fieldsets = BaseUserAdmin.add_fieldsets + (
        ('Informations supplémentaires', {'fields': ('phone', 'avatar', 'bio')}),
    )
    list_display = ['username', 'email', 'first_name', 'last_name', 'phone', 'is_staff']
    search_fields = ['username', 'email', 'first_name', 'last_name', 'phone']
