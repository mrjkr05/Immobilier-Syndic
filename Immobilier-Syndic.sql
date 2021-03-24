-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mer. 24 mars 2021 à 13:27
-- Version du serveur :  5.7.31
-- Version de PHP : 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `vigilence`
--

DELIMITER $$
--
-- Fonctions
--
DROP FUNCTION IF EXISTS `question_one`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `question_one` (`type_quartie` VARCHAR(20)) RETURNS INT(11) RETURN (SELECT COUNT(*) FROM `quartier`
INNER JOIN `bien_immobilier`
ON quartier.code_quartier=bien_immobilier.code_quartier 
WHERE bien_immobilier.type = type_quartie)$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `bien_immobilier`
--

DROP TABLE IF EXISTS `bien_immobilier`;
CREATE TABLE IF NOT EXISTS `bien_immobilier` (
  `code_bien` int(11) NOT NULL AUTO_INCREMENT,
  `adresse_bien` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `num_enregistrement` int(11) DEFAULT NULL,
  `superficie` double DEFAULT NULL,
  `type` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code_quartier` int(11) DEFAULT NULL,
  `date_construction` date DEFAULT NULL,
  PRIMARY KEY (`code_bien`),
  KEY `code_quartier` (`code_quartier`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `bien_immobilier`
--

INSERT INTO `bien_immobilier` (`code_bien`, `adresse_bien`, `num_enregistrement`, `superficie`, `type`, `code_quartier`, `date_construction`) VALUES
(1, '3 rue adda', 1, 60, 'batiment', 1, '2020-02-12'),
(2, '16 darb el yahoude', 2, 70, 'batiment', 1, '2020-02-12'),
(3, 'rue al atlas', 3, 1200, 'immuble', 3, '2020-02-12');

-- --------------------------------------------------------

--
-- Structure de la table `contrat`
--

DROP TABLE IF EXISTS `contrat`;
CREATE TABLE IF NOT EXISTS `contrat` (
  `numcontrat` int(11) NOT NULL AUTO_INCREMENT,
  `prix_mensuel` double UNSIGNED DEFAULT NULL,
  `code_bien` int(11) DEFAULT NULL,
  `code_syndic` int(11) DEFAULT NULL,
  `etat` varchar(20) COLLATE utf8_unicode_ci DEFAULT '{active,resillie}',
  PRIMARY KEY (`numcontrat`),
  KEY `code_bien` (`code_bien`,`code_syndic`),
  KEY `code_syndic` (`code_syndic`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `contrat`
--

INSERT INTO `contrat` (`numcontrat`, `prix_mensuel`, `code_bien`, `code_syndic`, `etat`) VALUES
(1, 25000, 1, 3, 'bien'),
(2, 2000, 2, 3, 'pas bien'),
(3, 50000, 3, 1, 'moyan');

-- --------------------------------------------------------

--
-- Structure de la table `quartier`
--

DROP TABLE IF EXISTS `quartier`;
CREATE TABLE IF NOT EXISTS `quartier` (
  `code_quartier` int(11) NOT NULL AUTO_INCREMENT,
  `nom_quartier` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `population_quartier` double DEFAULT NULL,
  `code_ville` int(11) DEFAULT NULL,
  `total_quartier` int(11) DEFAULT NULL,
  PRIMARY KEY (`code_quartier`),
  KEY `code_ville` (`code_ville`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `quartier`
--

INSERT INTO `quartier` (`code_quartier`, `nom_quartier`, `population_quartier`, `code_ville`, `total_quartier`) VALUES
(1, 'Gheraba Al Aalya', 120, 1, 2),
(2, 'Merbouha', 120, 1, 2),
(3, 'Maarif 1', 1200, 3, 2);

-- --------------------------------------------------------

--
-- Structure de la table `region`
--

DROP TABLE IF EXISTS `region`;
CREATE TABLE IF NOT EXISTS `region` (
  `code_region` int(11) NOT NULL AUTO_INCREMENT,
  `nom_region` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `population_region` double DEFAULT NULL,
  `total_region` int(11) DEFAULT NULL,
  PRIMARY KEY (`code_region`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `region`
--

INSERT INTO `region` (`code_region`, `nom_region`, `population_region`, `total_region`) VALUES
(1, 'Oriental', 2000, 1),
(2, 'Nord', 1000, 1),
(3, 'CasaBlanca', 20000, 1);

-- --------------------------------------------------------

--
-- Structure de la table `syndic`
--

DROP TABLE IF EXISTS `syndic`;
CREATE TABLE IF NOT EXISTS `syndic` (
  `code_syndic` int(11) NOT NULL AUTO_INCREMENT,
  `nom_syndic` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prenom_syndic` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `telephone_syndic` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mot_depasse` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`code_syndic`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `syndic`
--

INSERT INTO `syndic` (`code_syndic`, `nom_syndic`, `prenom_syndic`, `telephone_syndic`, `mot_depasse`) VALUES
(1, 'azenayn', 'mimoun', '0606060606', 'mimoun1212'),
(2, 'jerroudi', 'abdelmonaim', '0606060606', 'pedopedo123'),
(3, 'mimi', 'titi', '0606060606', 'testtest123');

-- --------------------------------------------------------

--
-- Structure de la table `ville`
--

DROP TABLE IF EXISTS `ville`;
CREATE TABLE IF NOT EXISTS `ville` (
  `code_ville` int(11) NOT NULL AUTO_INCREMENT,
  `nom_ville` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code_region` int(11) NOT NULL,
  `total_ville` int(11) DEFAULT NULL,
  PRIMARY KEY (`code_ville`),
  KEY `code_region` (`code_region`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `ville`
--

INSERT INTO `ville` (`code_ville`, `nom_ville`, `code_region`, `total_ville`) VALUES
(1, 'Berkane', 1, 1),
(2, 'Tafoughalt', 1, 1),
(3, 'Maarif', 3, 1);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `bien_immobilier`
--
ALTER TABLE `bien_immobilier`
  ADD CONSTRAINT `bien_immobilier_ibfk_1` FOREIGN KEY (`code_quartier`) REFERENCES `quartier` (`code_quartier`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `contrat`
--
ALTER TABLE `contrat`
  ADD CONSTRAINT `contrat_ibfk_1` FOREIGN KEY (`code_bien`) REFERENCES `bien_immobilier` (`code_bien`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `contrat_ibfk_2` FOREIGN KEY (`code_syndic`) REFERENCES `syndic` (`code_syndic`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `quartier`
--
ALTER TABLE `quartier`
  ADD CONSTRAINT `quartier_ibfk_1` FOREIGN KEY (`code_ville`) REFERENCES `ville` (`code_ville`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `ville`
--
ALTER TABLE `ville`
  ADD CONSTRAINT `ville_ibfk_1` FOREIGN KEY (`code_region`) REFERENCES `region` (`code_region`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

/*!Niveau 1*/;

2)SELECT count(*),ville.nom_ville  
 FROM `bien_immobilier` 
  INNER JOIN `quartier` 
   ON quartier.code_quartier=bien_immobilier.code_quartier
    INNER JOIN `ville` 
     ON ville.code_ville=quartier.code_ville
      GROUP BY ville.nom_ville

3)SELECT bien_immobilier.*, contrat.numcontrat 
 FROM `bien_immobilier` 
  INNER JOIN `contrat` 
   ON contrat.code_bien=bien_immobilier.code_bien
   	GROUP BY contrat.numcontrat

4)SELECT syndic.nom_syndic
 FROM `syndic`
  INNER JOIN `contrat`
   on contrat.code_syndic=syndic.code_syndic
    INNER JOIN `bien_immobilier`
     on contrat.code_bien=bien_immobilier.code_bien
      INNER JOIN `quartier`
      	on bien_immobilier.code_quartier=quartier.code_quartier
      	 INNER JOIN `ville`
      	  on ville.code_ville=quartier.code_ville
      	   INNER JOIN `region`
      	    on region.code_region=ville.code_region
      	     WHERE region.nom_region='oriental'
      	      AND syndic.code_syndic not in (
      	      	SELECT code_syndic
      	      	 FROM contrat
      	      	 ) 

5)SELECT bien_immobilier.*,MAX(contrat.prix_mensuel)
	 FROM `bien_immobilier` 
	 	inner join `contrat` 
	 		on contrat.code_bien=bien_immobilier.code_bien

6)SELECT bien_immobilier.*,MIN(bien_immobilier.date_construction) 
	FROM `bien_immobilier` 
		inner join `quartier` 
			on quartier.code_quartier=bien_immobilier.code_quartier 
				inner join `ville` 
					on ville.code_ville=quartier.code_ville 
						inner join `region` 
							on region.code_region=ville.code_region

7)SELECT syndic.nom_syndic, region.nom_region
 FROM `syndic`
  INNER JOIN `contrat`
   on contrat.code_syndic=syndic.code_syndic
    inner join  `bien_immobilier`
     on bien_immobilier.code_bien=contrat.code_bien
      inner join `quartier`
       on quartier.code_quartier=bien_immobilier.code_quartier
        inner join `ville`
         on ville.code_ville=quartier.code_quartier
          inner join `region`
           on region.code_region=ville.code_region
            HAVING MAX(contrat.numcontrat)

8)SELECT quartier.*
 FROM `quartier`
  inner join `bien_immobilier`
   on bien_immobilier.code_quartier=quartier.code_quartier
    inner join `contrat`
     on contrat.code_bien=bien_immobilier.code_bien
      HAVING COUNT(contrat.numcontrat) > 0

/*!Niveau 2*/;

1)
CREATE FUNCTION question_one(type_quartie varchar(20))
RETURNS int
RETURN (SELECT COUNT(*) FROM `quartier`
INNER JOIN `bien_immobilier`
ON quartier.code_quartier=bien_immobilier.code_quartier 
WHERE bien_immobilier.type = type_quartie)
GROUP BY quartier.nom_quartier

2)
