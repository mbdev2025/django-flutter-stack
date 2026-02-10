#!/usr/bin/env python3
import os
import secrets
from pathlib import Path

def main():
    print("🚀 Initialisation du projet Django + Flutter...")
    
    # Chemin vers le dossier backend
    base_dir = Path(__file__).parent.parent
    backend_dir = base_dir / 'backend'
    env_path = backend_dir / '.env'
    env_example = backend_dir / '.env.example'
    
    # 1. Générer .env si inexistant
    if env_path.exists():
        print("⚠️  Le fichier .env existe déjà, skip...")
    elif env_example.exists():
        secret_key = secrets.token_urlsafe(50)
        with open(env_example, 'r') as f:
            content = f.read()
        
        content = content.replace('your-secret-key-here-change-in-production', secret_key)
        
        with open(env_path, 'w') as f:
            f.write(content)
        print("✅ .env créé avec une SECRET_KEY sécurisée.")
    else:
        print("❌ Erreur: .env.example non trouvé.")

    # 2. Instructions finales
    print("\n📋 Prochaines étapes :")
    print("1. cd backend")
    print("2. python3 -m venv venv")
    print("3. source venv/bin/activate  # venv\\Scripts\\activate sur Windows")
    print("4. pip install -r requirements.txt")
    print("5. python manage.py migrate")
    print("6. python manage.py createsuperuser")
    print("7. python manage.py runserver")
    print("\n8. cd ../mobile")
    print("9. flutter pub get")
    print("10. flutter run")

if __name__ == "__main__":
    main()
