# Developer WorkCase Portfolio

[![Ruby Version](https://img.shields.io/badge/Ruby-2.4.1+-blue.svg)](https://www.ruby-lang.org)
[![Rails Version](https://img.shields.io/badge/Rails-5.2.8.1-red.svg)](https://rubyonrails.org)
[![Bundler Version](https://img.shields.io/badge/Bundler-2.3.27-green.svg)](https://bundler.io)
[![MySQL Version](https://img.shields.io/badge/MySQL-5.7-4479A1?logo=mysql&logoColor=white)](https://mysql.com/)

A legacy Rails 5.2.8.1 Project using Ruby 2.4.10, 

## 📖 Overview

This boilerplate provides a ready-to-run Rails 5.0.5 application configured with a stable gem stack that compiles cleanly on HostGator's legacy infrastructure (CentOS 7, EA Ruby 2.4.10, MySQL 5.7). It serves as a foundation for developers who need to:

- Pre-bundle and compile gems on a matching local environment before uploading to HostGator.
- Test applications locally in an environment identical to production.
- Package entire Ruby projects with all compiled extensions, ready to deploy.
- Avoid runtime compilation failures on the shared host.

## 🔗 Companion Docker Environment

This boilerplate is meant to be used inside the HostGator Shared Plans Docker environment, which replicates HostGator's exact production stack:

```bash
# Clone the Docker environment
git clone https://github.com/j-fborges/hostgator_shared_plans_docker.git
cd hostgator_shared_plans_docker
# Follow its README to set up the environment
./bin/setup.sh
```

## 🏗️ Technical Stack

| Component | Version | Notes |
|--------------------|------------------------------------|------------------------------------|
| Ruby               | 2.4.10                             | Compiled from source (EA Ruby 24)  |
| Rails              | 5.0.5                              | LTS release, stable for production |
| Bundler            | 2.3.27                             | Exact version for compatibility    |
| RubyGems           | 2.6.14.4                           | Required for Ruby 2.4.10           |
| MySQL              | 5.7.44                             | Client libraries and devel headers |
| JavaScript runtime | therubyracer (0.12.3) with V8 3.16 | No Node.js required – pure Ruby    |
| CSS/JS Minifier    | uglifier                           |                                    |
| Frontend           | Bootstrap-scss                     |                                    |
| Asset Pipeline     | Sprockets 3.7.5                    | Classic Rails asset handling       |

## ✨ Features

- Bootstrap-scss with full SCSS support
- jQuery-ujs for unobtrusive JavaScript (Rails 5 standard)
- Turbolinks for faster page navigation
- MySQL database ready with sample configuration
- Puma and Passenger both available as web servers
- Production-ready asset compilation with uglifier-compressor
- Development and Production environment scripts included

## 🚀 Quick Start (with Docker Environment)

### 1. Set up the Docker Environment

```bash
git clone https://github.com/j-fborges/hostgator_shared_plans_docker.git
cd hostgator_shared_plans_docker
cp .env.example .env
# Edit .env with your custom paths
./bin/setup.sh
./bin/start.sh
```

### 2. Clone this Boilerplate Inside the Container

Once inside the container (you'll be dropped into a bash shell after ./bin/start.sh), navigate to:

```bash
 cd /your/projects/folder/
 git clone https://github.com/j-fborges/hostgator_shared_rails_boilerplate.git
```

### 3. Install Dependencies

```bash
bundle install
```

### 4. Configure Database

Edit config/database.yml to match your MySQL service. The Docker environment provides a MySQL container with these default credentials:

```bash
development:
  adapter: mysql2
  encoding: utf8
  database: myapp_development
  username: myapp_user
  password: myapp_password
  host: mysql      # service name from docker-compose
  port: 3306
```

### 5. Create and Migrate Database

```bash
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:seed # if you have seed data
```

### 6. Run the Development Server

```bash
bundle exec rails s -b 0.0.0.0
```

Your app will be accessible from your host machine at http://127.0.0.1:3000.

## 📜 Included Scripts

| Script                        | Purpose |
|-------------------------------|-----------------------------------------------------------------------|
| deploy-production.sh          | Full production deployment: cleans assets, installs gems, precompiles |
| runDevServer.sh               | Quick development server launcher with proper binding                 |
| set-development-mode.sh       | Switches environment to development (sets RAILS_ENV, cleans if needed)|
| set-production-environment.sh | Switches environment to production (prepares for asset compilation)   |

## 🧪 Development Workflow

1. Make changes to your code inside the mounted dev_portfolio folder.

2. Run the development server:
 ```bash
 ./runDevServer.sh 
 ```
3. Test your changes at http://localhost:3000.

4. Switch to production mode to test final assets:
 ```bash
 ./set-production-environment.sh
 ./deploy-production.sh
 bundle exec rails s -b 0.0.0.0 -e production 
 ```
5. Switch back to development when done:
 ```bash
 ./set-development-mode.sh
 ```

## 📦 Preparing for HostGator Deployment

The primary goal of this boilerplate + Docker environment is to create a deployable package that runs on HostGator without needing compilation.

### Step 1: Full Production Build

Inside the container, run:

```bash
./deploy-production.sh 
```

This script:
- Sets RAILS_ENV=production
- Cleans old assets (tmp/cache/assets, public/assets)
- Configures Bundler for production (--without development test)
- Installs all gems (compiles native extensions)
- Precompiles all assets using uglifier compressor
- Packages everything for shipping

### Step 2: Upload to HostGator

Use SCP/SFTP to upload the tarball to your HostGator account and extract it in your home directory.

## 🔗 Related Projects

- HostGator Shared Plans Docker – The Docker environment this boilerplate is designed for.