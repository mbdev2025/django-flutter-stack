{ pkgs, ... }: {
  # Utilisation d'un canal stable pour éviter les ruptures de SDK
  channel = "stable-23.11";

  packages = [
    # --- Backend & Outils Système ---
    pkgs.python311
    pkgs.python311Packages.pip
    pkgs.python311Packages.virtualenv
    pkgs.postgresql
    pkgs.redis
    pkgs.git
    
    # --- Mobile Flutter & Android ---
    pkgs.flutter
    pkgs.jdk17
    pkgs.android-tools
    pkgs.unzip
  ];

  # Variables d'environnement pour lier les deux mondes
  env = {
    PYTHON_VERSION = "3.11";
    DJANGO_SETTINGS_MODULE = "config.settings";
    # Force Flutter à utiliser le JDK fourni par Nix
    JAVA_HOME = "${pkgs.jdk17.home}";
  };

  services = {
    redis.enable = true;
    postgres = {
      enable = true;
      package = pkgs.postgresql;
    };
  };

  idx = {
    # Extensions indispensables pour ton flux de travail
    extensions = [
      "ms-python.python"
      "batisteo.vscode-django"
      "Dart-Code.flutter"
      "ms-azuretools.vscode-docker"
    ];

    workspace = {
      # S'exécute une seule fois à la création du projet
      onCreate = {
        setup-project = ''
          # 1. Setup Backend (Respect de ton script existant)
          cd backend
          python3 -m venv venv
          source venv/bin/activate
          pip install --upgrade pip
          if [ -f requirements-idx.txt ]; then pip install -r requirements-idx.txt; fi
          if [ ! -f .env ]; then cp .env.example .env; fi
          python manage.py migrate
          
          # 2. Setup Mobile
          cd ../mobile
          flutter pub get
          # Acceptation automatique des licences Android
          yes | flutter doctor --android-licenses
        '';
      };
      
      # S'exécute à chaque ouverture du workspace
      onStart = {
        # S'assure que les dépendances sont à jour
        update-flutter = "cd mobile && flutter pub get";
      };
    };

    # --- CONFIGURATION DES PRÉVISUALISATIONS ---
    previews = {
      enable = true;
      previews = {
        # Preview 1 : Ton API Django
        backend = {
          command = ["backend/venv/bin/python" "backend/manage.py" "runserver" "0.0.0.0:8000"];
          manager = "web";
        };

        # Preview 2 : Ton App Flutter sur Émulateur
        android = {
          command = ["flutter" "run" "--machine" "-d" "android" "-v"];
          manager = "android";
          cwd = "mobile";
        };
      };
    };
  };
}