# Minishell

Un shell Unix minimal implémenté en C, reproduisant les fonctionnalités essentielles d'un shell bash.

## Fonctionnalités

- Exécution de commandes système
- Pipes (`|`) - chaînage de commandes
- Redirections (`>`, `>>`, `<`, `<<`)
- Variables d'environnement
- Historique des commandes
- Gestion des signaux

## Prérequis

- Compilateur C (gcc/clang)
- GNU Make
- readline library
- Unix/Linux/macOS

## Installation

```bash
git clone https://github.com/yourusername/minishell.git
cd minishell
make
```

## Utilisation

```bash
./minishell
```

## Commandes Intégrées

- `echo` - Affiche du texte
- `cd` - Changer de répertoire
- `pwd` - Affichage du répertoire courant
- `export` - Variables d'environnement
- `unset` - Suppression de variables
- `env` - Affichage de l'environnement
- `exit` - Quitter le shell

## Exemples

```bash
minishell> ls -la
minishell> cat file.txt | grep "pattern"
minishell> echo "Hello" > output.txt
minishell> export MY_VAR=value
minishell> cd /tmp
minishell> exit
```

## Compilation

```bash
make           # Compilation standard
make clean     # Supprimer les fichiers objets
make fclean    # Supprimer tout (objets + exécutable)
make re        # Recompilation complète
```

## Licence

MIT License - voir [LICENSE](LICENSE)
