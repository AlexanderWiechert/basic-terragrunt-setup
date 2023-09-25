# AWS VPC core Konfiguiration

> Dies ist kein vollständiges Terraform Projekt. Es dient nur als Beispiel für ein Projektsetup mit **Terragrunt**.


## Lokal
Wenn man das Projekt vom lokalen Entwicklerrechner deployen oder testen will, muss die Datei accounts/user.yaml.dist
umbenannt werden und folgende Einstellungen müssen angepasst werden.
```
aws:
    profile_accounts:
        prod: "elastic2ls  -prod"
        dev: "elastic2ls-dev"
```
Die Profileinträge müssen den Profil-Einträgen in der `~/.aws/config` entsprechen. Der Prefix muss dem Ordner unter `accounts` entsprechen.

In der jeweiligen `terragrunt.hcl` Datei muss folgendes ein Profil für das S3 Backend und den Provider hinzugefügt werden für das Mapping.



## Einstieg ins Projekt
Typischer Einstieg in eine "Terraform mit Terragrunt" Projekt ist die **stage/terragrunt.hcl** Datei.
Dort können die Backends, dynamisch konfigurierbare Authentication Provider und Merge Anweisungen für die 
Yaml Dateien und Extra Argumenten angegeben werden.