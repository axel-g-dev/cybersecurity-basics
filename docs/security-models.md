# Résumé pour chacun des trois modèles de sécurité :

Modèle Bell-LaPadula
Objectif principal : Assurer la confidentialité des données.

Principe : Ce modèle empêche l'information de "fuiter" vers des niveaux de sécurité inférieurs. Il est basé sur des niveaux d'habilitation (ex: Secret, Top Secret).

Règles clés :

Pas de lecture vers le haut (No Read Up) : Un utilisateur (sujet) ne peut pas lire des données classées à un niveau de sécurité supérieur au sien.

Pas d'écriture vers le bas (No Write Down) : Un utilisateur ne peut pas écrire d'informations dans un fichier classé à un niveau de sécurité inférieur au sien (pour éviter de divulguer une information confidentielle).

Résumé : "Écrire vers le haut, lire vers le bas" (Write up, read down).

Modèle Biba
Objectif principal : Assurer l'intégrité des données (c'est-à-dire leur exactitude et leur fiabilité).

Principe : C'est l'opposé mathématique de Bell-LaPadula. Il empêche les données non fiables de "contaminer" les données fiables.

Règles clés :

Pas de lecture vers le bas (No Read Down) : Un utilisateur ne peut pas lire des données provenant d'un niveau d'intégrité inférieur (pour ne pas être "corrompu" par des données non fiables).

Pas d'écriture vers le haut (No Write Up) : Un utilisateur ne peut pas écrire de données vers un niveau d'intégrité supérieur (pour ne pas "corrompre" des données fiables avec des informations potentiellement incorrectes).

Résumé : "Lire vers le haut, écrire vers le bas" (Read up, write down).

Modèle Clark-Wilson
Objectif principal : Assurer l'intégrité des données, mais en se concentrant sur la manière dont elles sont modifiées.

Principe : Ce modèle sépare les données des opérations. Les utilisateurs ne peuvent pas modifier directement les données ; ils doivent utiliser des programmes certifiés pour le faire.

Concepts clés :

CDI (Constrained Data Item) : Les données dont l'intégrité doit être protégée.

TP (Transformation Procedures) : Les seuls programmes/opérations autorisés à modifier les CDI. Ce sont des "intermédiaires" de confiance.

IVP (Integrity Verification Procedures) : Des procédures qui vérifient que les données (CDI) sont toujours dans un état valide et cohérent.
