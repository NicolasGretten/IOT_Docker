staging_build_payment:
  stage: staging-build
  allow_failure: false
  rules:
    - if: $CI_COMMIT_BRANCH == "staging"
      changes:
        - "payment/*"
        - "payment/*/*"
        - "payment/*/*/*"
  environment:
    name: staging
    url: https://staging.payment.collectandverything.fr
  tags:
    - staging
  script:
    - cd /home/admin/docker.collect.verything/payment && sudo cp env/.env.staging .env && sudo -E docker compose build --no-cache

staging_test_payment:
  stage: staging-test
  allow_failure: false
  rules:
    - if: $CI_COMMIT_BRANCH == "staging"
  tags:
    - staging
  script:
    - sudo docker run -d --name payment-test-php collectandverything-payment:latest
    - sudo docker exec payment-test-php /bin/bash -c 'phpcs --standard=PSR12 app/ > output.xml || true'
    - sudo docker exec payment-test-php /bin/bash -c 'php artisan test > test.xml || true'
    - sudo docker cp payment-test-php:/var/www/output.xml phpcs-payment.xml
    - sudo docker cp payment-test-php:/var/www/test.xml phpunit-payment.xml
  after_script:
    - sudo docker rm -f payment-test-php
  artifacts:
    paths:
      - "*.xml"

staging_deploy_payment:
  stage: staging-deploy
  allow_failure: false
  rules:
    - if: $CI_COMMIT_BRANCH == "staging"
  tags:
    - staging
  script:
    - cd /home/admin/docker.collect.verything/payment && sudo -E docker compose up -d

staging_scan_payment:
  stage: staging-scan
  allow_failure: false
  rules:
    - if: $CI_COMMIT_BRANCH == "staging"
  tags:
    - staging
  script:
    - sudo trivy payment --severity CRITICAL,HIGH collectandverything-payment:latest
