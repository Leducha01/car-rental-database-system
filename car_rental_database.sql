-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 08, 2024 at 02:55 PM
-- Wersja serwera: 10.4.28-MariaDB
-- Wersja PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wypozyczalnia_samochodow`
--

DELIMITER $$
--
-- Procedury
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `aktualizuj_klienta` (IN `idp` INT, IN `imiep` VARCHAR(50), IN `nazwiskop` VARCHAR(50), IN `emailp` VARCHAR(50), IN `telefonp` INT(13), IN `miejscowoscp` VARCHAR(50))   BEGIN
UPDATE klienci SET imie = imiep, nazwisko = nazwiskop, `e-mail`=emailp, telefon = telefonp, miejscowosc = miejscowoscp WHERE idKlienta = idp;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cena_wszystkich_pojazdow` ()   BEGIN
SELECT SUM(Cena) AS `Cena_wszystkich_Pojazdow` FROM pojazdy;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `dodaj_klienta` (IN `imiep` VARCHAR(50), IN `nazwiskop` VARCHAR(50), IN `emailp` VARCHAR(50), IN `telefonp` INT(13), IN `miejscowoscp` VARCHAR(50))   BEGIN
 INSERT INTO klienci (imie, nazwisko, `e-mail`, telefon, miejscowosc)
 VALUES (imiep ,nazwiskop,emailp, telefonp, miejscowoscp);
 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ilosc_rekordow` (IN `tabela` VARCHAR(255))   BEGIN
SELECT COUNT(*) FROM tabela;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `usun_klienta` (IN `id` INT)   BEGIN
DELETE FROM klienci WHERE idKlienta = id;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `cena_wszystkich_pojazdow` () RETURNS INT(11)  BEGIN
DECLARE cena_wszystkich_pojazdow INT;
SELECT SUM(cena) INTO cena_wszystkich_pojazdow FROM pojazdy;
RETURN cena_wszystkich_pojazdow;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `klienci`
--

CREATE TABLE `klienci` (
  `IdKlienta` int(11) NOT NULL,
  `Imie` varchar(100) DEFAULT NULL,
  `Nazwisko` varchar(200) DEFAULT NULL,
  `E-mail` varchar(200) DEFAULT NULL,
  `Telefon` int(11) DEFAULT NULL,
  `Miejscowosc` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Dumping data for table `klienci`
--

INSERT INTO `klienci` (`IdKlienta`, `Imie`, `Nazwisko`, `E-mail`, `Telefon`, `Miejscowosc`) VALUES
(1, 'Katarzyna', 'Kowalska', 'kkowalska@gmail.com', 325476318, 'Warszawa'),
(2, 'Marek', 'Nowak', 'mnowak@gmail.com', 354756922, 'Warszawa'),
(3, 'Anna', 'Wójcik', 'awojcik@gmail.com', 564889566, 'Poznań'),
(4, 'Piotr', 'Kaczmarek', 'pkaczmarek@gmail.com', 452871424, 'Kraków'),
(5, 'Kamila', 'Kowalska', 'kszymanska@gmail.com', 376328991, 'Warszawa'),
(6, 'Tomasz', 'Kowalczyk', 'tkowalczyk@gmail.com', 365487291, 'Łódź'),
(7, 'Jan', 'Lewandowski', 'jlewandowski@gmail.com', 653982129, 'Poznań'),
(8, 'Mariusz', 'Kowalczyk', 'mkowalczyk@gmail.com', 564123413, 'Łódź'),
(9, 'Zygmunt', 'Bartoszewski', 'zbartoszewski@gmail.com', 374526398, 'Warszawa'),
(10, 'Jacek', 'Mickiewicz', 'jmioduszewski@gmail.com', 567823911, 'Kraków');

--
-- Wyzwalacze `klienci`
--
DELIMITER $$
CREATE TRIGGER `klient_delete` BEFORE DELETE ON `klienci` FOR EACH ROW BEGIN
DELETE FROM Rezerwacje WHERE IdKlienta = OLD.IdKlienta;
DELETE FROM Umowy WHERE IdKlienta = OLD.IdKlienta;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pojazdy`
--

CREATE TABLE `pojazdy` (
  `IdPojazdu` int(11) NOT NULL,
  `Marka` varchar(100) DEFAULT NULL,
  `Model` varchar(100) DEFAULT NULL,
  `RokProdukcji` int(11) DEFAULT NULL,
  `Przebieg` int(11) DEFAULT NULL,
  `Silnik` varchar(50) DEFAULT NULL,
  `RodzajPaliwa` varchar(10) DEFAULT NULL,
  `SkrzyniaBiegow` varchar(20) DEFAULT NULL,
  `Cena` int(11) DEFAULT NULL,
  `IdUbezpieczenia` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Dumping data for table `pojazdy`
--

INSERT INTO `pojazdy` (`IdPojazdu`, `Marka`, `Model`, `RokProdukcji`, `Przebieg`, `Silnik`, `RodzajPaliwa`, `SkrzyniaBiegow`, `Cena`, `IdUbezpieczenia`) VALUES
(1, 'Toyota', 'Camry', 2018, 132488, '2.5', 'Benzyna', 'Automatyczna', 58, 1),
(2, 'Audi', 'A4', 2019, 87456, '2.0', 'Benzyna', 'Automatyczna', 83, 2),
(3, 'Jeep', 'Grand Cherokee', 2016, 192726, '3.6', 'Benzyna', 'Manualna', 74, 3),
(4, 'Peugeot', '308', 2018, 213876, '1.6', 'Diesel', 'Manualna', 50, 4),
(5, 'Honda', 'Civic', 2017, 113878, '1.5', 'Benzyna', 'Manualna', 68, 5),
(6, 'BMW', 'X3', 2017, 82345, '2.0', 'Benzyna', 'Automatyczna', 75, 6),
(7, 'Toyota', 'RAV4', 2018, 91263, '2.5', 'Diesel', 'Manualna', 70, 7),
(8, 'Volkswagen', 'Golf', 2019, 76543, '1.4', 'Diesel', 'Manualna', 78, 8),
(9, 'Jeep', 'Wrangler', 2019, 54394, '3.6', 'Benzyna', 'Manualna', 90, 9),
(10, 'Mazda', 'CX-50', 2019, 87923, '2.2', 'Diesel', 'Automatyczna', 70, 10),
(11, 'Audi', 'A5', 2018, 92108, '2.0', 'Benzyna', 'Automatyczna', 85, 11),
(12, 'Ford', 'Focus', 2018, 112764, '1.6', 'Diesel', 'Manualna', 67, 12),
(13, 'Toyota', 'Corolla', 2016, 154876, '1.8', 'Benzyna', 'Manualna', 55, 13),
(14, 'Volkswagen', 'Passat', 2017, 142675, '2.0', 'Diesel', 'Manualna', 54, 14),
(15, 'Jeep', 'Renegade', 2018, 87456, '1.3', 'Benzyna', 'Automatyczna', 62, 15);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pracownicy`
--

CREATE TABLE `pracownicy` (
  `idPracownika` int(11) NOT NULL,
  `imie` text NOT NULL,
  `nazwisko` text NOT NULL,
  `email` text DEFAULT NULL,
  `stanowisko` int(11) DEFAULT 1,
  `idKierownika` int(11) NOT NULL,
  `DataDodania` date DEFAULT NULL,
  `DataZaktualizowania` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Dumping data for table `pracownicy`
--

INSERT INTO `pracownicy` (`idPracownika`, `imie`, `nazwisko`, `email`, `stanowisko`, `idKierownika`, `DataDodania`, `DataZaktualizowania`) VALUES
(1, 'Mariusz', 'Słowacki', 'mslowacki@gmail.com', 1, 2, '2023-11-15', NULL),
(2, 'Zgigniew', 'Jastrząb', 'zjastrzab@gmail.com', 2, 0, '2023-12-07', NULL),
(3, 'Joanna', 'Nowak', 'jnowak@gmail.com', 3, 0, '2023-12-13', NULL),
(4, 'Maciej', 'Kowalski', 'mkowalski@gmail.com', 2, 2, '2024-01-24', NULL),
(5, 'Tadeusz', 'Wiśniewski', 'twisniewski@gmail.com', 1, 3, '2024-02-20', NULL),
(6, 'Cezary', 'Nowak', 'cnowak@gmail.com', 3, 2, '2024-04-03', NULL);

--
-- Wyzwalacze `pracownicy`
--
DELIMITER $$
CREATE TRIGGER `pracownik_insert_date` BEFORE INSERT ON `pracownicy` FOR EACH ROW BEGIN
SET NEW.DataDodania = NOW();
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `rezerwacje`
--

CREATE TABLE `rezerwacje` (
  `IdRezerwacji` int(11) NOT NULL,
  `IdKlienta` int(11) DEFAULT NULL,
  `IdPojazdu` int(11) DEFAULT NULL,
  `Data rozpoczecia` datetime DEFAULT NULL,
  `Data zakonczenia` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Dumping data for table `rezerwacje`
--

INSERT INTO `rezerwacje` (`IdRezerwacji`, `IdKlienta`, `IdPojazdu`, `Data rozpoczecia`, `Data zakonczenia`) VALUES
(1, 1, 8, '2024-01-07 00:00:00', '2024-01-14 00:00:00'),
(2, 2, 6, '2024-01-03 00:00:00', '2024-01-05 00:00:00'),
(3, 3, 2, '2023-12-29 00:00:00', '2024-02-01 00:00:00'),
(4, 5, 3, '2023-12-26 00:00:00', '2024-01-01 00:00:00'),
(5, 6, 9, '2023-12-17 00:00:00', '2023-12-23 00:00:00'),
(6, 2, 1, '2023-12-06 00:00:00', '2023-12-13 00:00:00'),
(7, 4, 5, '2024-01-20 00:00:00', '2024-01-25 00:00:00'),
(8, 7, 2, '2024-02-11 00:00:00', '2024-02-18 00:00:00'),
(9, 8, 2, '2024-02-01 00:00:00', '2024-02-03 00:00:00'),
(10, 9, 4, '2024-02-21 00:00:00', '2024-02-23 00:00:00'),
(11, 10, 1, '2024-03-01 00:00:00', '2024-03-05 00:00:00');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `szkody`
--

CREATE TABLE `szkody` (
  `IdSzkody` int(11) NOT NULL,
  `IdKlienta` int(11) DEFAULT NULL,
  `IdPojazdu` int(11) DEFAULT NULL,
  `Kwota` int(11) DEFAULT NULL,
  `Opis` varchar(255) DEFAULT NULL,
  `Data` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Dumping data for table `szkody`
--

INSERT INTO `szkody` (`IdSzkody`, `IdKlienta`, `IdPojazdu`, `Kwota`, `Opis`, `Data`) VALUES
(4, 3, 2, 500, 'zarysowany przedni zderzak prawy', '2024-02-06 21:41:23'),
(5, 6, 9, 1400, 'wgniecenie zderzak prawy tylni', '0000-00-00 00:00:00'),
(6, 2, 1, 300, 'pobrudzona tapicerka', '2023-08-12 00:00:00');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tankowania`
--

CREATE TABLE `tankowania` (
  `IdTankowania` int(11) NOT NULL,
  `IdPojazdu` int(11) DEFAULT NULL,
  `DataTankowania` datetime DEFAULT NULL,
  `kosztTankowania` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `ubezpieczenia`
--

CREATE TABLE `ubezpieczenia` (
  `IdUbezpieczenia` int(11) NOT NULL,
  `Data waznosci` datetime DEFAULT NULL,
  `Ubezpieczyciel` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Dumping data for table `ubezpieczenia`
--

INSERT INTO `ubezpieczenia` (`IdUbezpieczenia`, `Data waznosci`, `Ubezpieczyciel`) VALUES
(1, '2024-01-27 00:00:00', 'PZU'),
(2, '2024-03-17 00:00:00', 'PZU'),
(3, '2024-08-10 00:00:00', 'PZU'),
(4, '2024-10-05 00:00:00', 'PZU'),
(5, '2024-08-30 00:00:00', 'AXA'),
(6, '2025-01-17 00:00:00', 'PZU'),
(7, '2024-08-30 00:00:00', 'AXA'),
(8, '2024-04-12 00:00:00', 'AXA'),
(9, '2024-11-22 00:00:00', 'Allianz'),
(10, '2024-05-04 00:00:00', 'AXA'),
(11, '2024-10-11 13:56:40', 'PZU'),
(12, '2024-08-06 00:00:00', 'AXA'),
(13, '2024-11-08 00:00:00', 'PZU'),
(14, '2024-05-10 00:00:00', 'Allianz'),
(15, '2024-09-16 00:00:00', 'AXA');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `umowy`
--

CREATE TABLE `umowy` (
  `IdUmowy` int(11) NOT NULL,
  `IdKlienta` int(11) DEFAULT NULL,
  `IdPojazdu` int(11) DEFAULT NULL,
  `Data zawarcia` datetime DEFAULT NULL,
  `Data zakonczenia` datetime DEFAULT NULL,
  `IdRezerwacji` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Dumping data for table `umowy`
--

INSERT INTO `umowy` (`IdUmowy`, `IdKlienta`, `IdPojazdu`, `Data zawarcia`, `Data zakonczenia`, `IdRezerwacji`) VALUES
(1, 1, 8, '2024-01-08 00:00:00', '2024-01-14 00:00:00', 1),
(2, 2, 6, '2024-01-03 00:00:00', '2024-01-05 00:00:00', 2),
(3, 3, 2, '2023-12-29 00:00:00', '2024-02-01 00:00:00', 3),
(4, 5, 3, '2023-12-26 00:00:00', '2024-01-01 00:00:00', 4),
(5, 6, 9, '2023-12-17 00:00:00', '2023-12-23 00:00:00', 5),
(6, 2, 1, '2023-12-06 00:00:00', '2023-12-13 00:00:00', 6),
(7, 4, 5, '2024-01-20 00:00:00', '2024-01-24 00:00:00', 7),
(8, 7, 2, '2024-02-11 00:00:00', '2024-02-18 00:00:00', 8),
(9, 8, 2, '2024-02-01 00:00:00', '2024-02-03 00:00:00', 9);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `widokcount`
-- (See below for the actual view)
--
CREATE TABLE `widokcount` (
`pojazdy_ponizej_70` bigint(21)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `widokhaving`
-- (See below for the actual view)
--
CREATE TABLE `widokhaving` (
`rokProdukcji` int(11)
,`liczba_samochodow` bigint(21)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `widokjoin`
-- (See below for the actual view)
--
CREATE TABLE `widokjoin` (
`marka` varchar(100)
,`model` varchar(100)
,`ubezpieczyciel` varchar(50)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `widoklike`
-- (See below for the actual view)
--
CREATE TABLE `widoklike` (
`imie` varchar(100)
,`nazwisko` varchar(200)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `widoktriplewhere`
-- (See below for the actual view)
--
CREATE TABLE `widoktriplewhere` (
`idKlienta` int(11)
,`Imie` varchar(100)
,`Nazwisko` varchar(200)
,`Data rozpoczecia` datetime
,`Data zakonczenia` datetime
,`idPojazdu` int(11)
,`Marka` varchar(100)
,`Model` varchar(100)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `widokwhere`
-- (See below for the actual view)
--
CREATE TABLE `widokwhere` (
`idPojazdu` int(11)
,`marka` varchar(100)
,`model` varchar(100)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `widokwhereorderby`
-- (See below for the actual view)
--
CREATE TABLE `widokwhereorderby` (
`marka` varchar(100)
,`model` varchar(100)
,`cena` int(11)
);

-- --------------------------------------------------------

--
-- Struktura widoku `widokcount`
--
DROP TABLE IF EXISTS `widokcount`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `widokcount`  AS SELECT count(0) AS `pojazdy_ponizej_70` FROM `pojazdy` WHERE `pojazdy`.`Cena` < 70 ;

-- --------------------------------------------------------

--
-- Struktura widoku `widokhaving`
--
DROP TABLE IF EXISTS `widokhaving`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `widokhaving`  AS SELECT `pojazdy`.`RokProdukcji` AS `rokProdukcji`, count(0) AS `liczba_samochodow` FROM `pojazdy` GROUP BY `pojazdy`.`RokProdukcji` HAVING count(0) >= 2 ;

-- --------------------------------------------------------

--
-- Struktura widoku `widokjoin`
--
DROP TABLE IF EXISTS `widokjoin`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `widokjoin`  AS SELECT `pojazdy`.`Marka` AS `marka`, `pojazdy`.`Model` AS `model`, `ubezpieczenia`.`Ubezpieczyciel` AS `ubezpieczyciel` FROM (`pojazdy` join `ubezpieczenia` on(`pojazdy`.`IdUbezpieczenia` = `ubezpieczenia`.`IdUbezpieczenia`)) ;

-- --------------------------------------------------------

--
-- Struktura widoku `widoklike`
--
DROP TABLE IF EXISTS `widoklike`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `widoklike`  AS SELECT `klienci`.`Imie` AS `imie`, `klienci`.`Nazwisko` AS `nazwisko` FROM `klienci` WHERE `klienci`.`Imie` like '%a' ;

-- --------------------------------------------------------

--
-- Struktura widoku `widoktriplewhere`
--
DROP TABLE IF EXISTS `widoktriplewhere`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `widoktriplewhere`  AS SELECT `k`.`IdKlienta` AS `idKlienta`, `k`.`Imie` AS `Imie`, `k`.`Nazwisko` AS `Nazwisko`, `r`.`Data rozpoczecia` AS `Data rozpoczecia`, `r`.`Data zakonczenia` AS `Data zakonczenia`, `p`.`IdPojazdu` AS `idPojazdu`, `p`.`Marka` AS `Marka`, `p`.`Model` AS `Model` FROM ((`klienci` `k` join `rezerwacje` `r` on(`k`.`IdKlienta` = `r`.`IdKlienta`)) join `pojazdy` `p` on(`r`.`IdPojazdu` = `p`.`IdPojazdu`)) WHERE `k`.`Miejscowosc` = 'Warszawa' ;

-- --------------------------------------------------------

--
-- Struktura widoku `widokwhere`
--
DROP TABLE IF EXISTS `widokwhere`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `widokwhere`  AS SELECT `pojazdy`.`IdPojazdu` AS `idPojazdu`, `pojazdy`.`Marka` AS `marka`, `pojazdy`.`Model` AS `model` FROM `pojazdy` WHERE `pojazdy`.`Cena` > 80 ;

-- --------------------------------------------------------

--
-- Struktura widoku `widokwhereorderby`
--
DROP TABLE IF EXISTS `widokwhereorderby`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `widokwhereorderby`  AS SELECT `pojazdy`.`Marka` AS `marka`, `pojazdy`.`Model` AS `model`, `pojazdy`.`Cena` AS `cena` FROM `pojazdy` WHERE `pojazdy`.`Cena` > 80 ORDER BY `pojazdy`.`Cena` ASC ;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `klienci`
--
ALTER TABLE `klienci`
  ADD PRIMARY KEY (`IdKlienta`);

--
-- Indeksy dla tabeli `pojazdy`
--
ALTER TABLE `pojazdy`
  ADD PRIMARY KEY (`IdPojazdu`),
  ADD KEY `IdUbezpieczenia` (`IdUbezpieczenia`);

--
-- Indeksy dla tabeli `pracownicy`
--
ALTER TABLE `pracownicy`
  ADD PRIMARY KEY (`idPracownika`),
  ADD UNIQUE KEY `email` (`email`) USING HASH;

--
-- Indeksy dla tabeli `rezerwacje`
--
ALTER TABLE `rezerwacje`
  ADD PRIMARY KEY (`IdRezerwacji`),
  ADD KEY `IdPojazdu` (`IdPojazdu`),
  ADD KEY `IdKlienta` (`IdKlienta`);

--
-- Indeksy dla tabeli `szkody`
--
ALTER TABLE `szkody`
  ADD PRIMARY KEY (`IdSzkody`),
  ADD KEY `IdPojazdu` (`IdPojazdu`),
  ADD KEY `IdKlienta` (`IdKlienta`);

--
-- Indeksy dla tabeli `tankowania`
--
ALTER TABLE `tankowania`
  ADD PRIMARY KEY (`IdTankowania`),
  ADD KEY `IdPojazdu` (`IdPojazdu`);

--
-- Indeksy dla tabeli `ubezpieczenia`
--
ALTER TABLE `ubezpieczenia`
  ADD PRIMARY KEY (`IdUbezpieczenia`);

--
-- Indeksy dla tabeli `umowy`
--
ALTER TABLE `umowy`
  ADD PRIMARY KEY (`IdUmowy`),
  ADD KEY `IdKlienta` (`IdKlienta`),
  ADD KEY `IdPojazdu` (`IdPojazdu`),
  ADD KEY `IdRezerwacji` (`IdRezerwacji`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `klienci`
--
ALTER TABLE `klienci`
  MODIFY `IdKlienta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `pojazdy`
--
ALTER TABLE `pojazdy`
  MODIFY `IdPojazdu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `pracownicy`
--
ALTER TABLE `pracownicy`
  MODIFY `idPracownika` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `rezerwacje`
--
ALTER TABLE `rezerwacje`
  MODIFY `IdRezerwacji` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `szkody`
--
ALTER TABLE `szkody`
  MODIFY `IdSzkody` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tankowania`
--
ALTER TABLE `tankowania`
  MODIFY `IdTankowania` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ubezpieczenia`
--
ALTER TABLE `ubezpieczenia`
  MODIFY `IdUbezpieczenia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `umowy`
--
ALTER TABLE `umowy`
  MODIFY `IdUmowy` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `pojazdy`
--
ALTER TABLE `pojazdy`
  ADD CONSTRAINT `pojazdy_ibfk_1` FOREIGN KEY (`IdUbezpieczenia`) REFERENCES `ubezpieczenia` (`IdUbezpieczenia`);

--
-- Constraints for table `rezerwacje`
--
ALTER TABLE `rezerwacje`
  ADD CONSTRAINT `rezerwacje_ibfk_1` FOREIGN KEY (`IdPojazdu`) REFERENCES `pojazdy` (`IdPojazdu`),
  ADD CONSTRAINT `rezerwacje_ibfk_2` FOREIGN KEY (`IdKlienta`) REFERENCES `klienci` (`IdKlienta`);

--
-- Constraints for table `szkody`
--
ALTER TABLE `szkody`
  ADD CONSTRAINT `szkody_ibfk_1` FOREIGN KEY (`IdPojazdu`) REFERENCES `pojazdy` (`IdPojazdu`),
  ADD CONSTRAINT `szkody_ibfk_2` FOREIGN KEY (`IdKlienta`) REFERENCES `klienci` (`IdKlienta`);

--
-- Constraints for table `umowy`
--
ALTER TABLE `umowy`
  ADD CONSTRAINT `umowy_ibfk_1` FOREIGN KEY (`IdKlienta`) REFERENCES `klienci` (`IdKlienta`),
  ADD CONSTRAINT `umowy_ibfk_2` FOREIGN KEY (`IdPojazdu`) REFERENCES `pojazdy` (`IdPojazdu`),
  ADD CONSTRAINT `umowy_ibfk_3` FOREIGN KEY (`IdRezerwacji`) REFERENCES `rezerwacje` (`IdRezerwacji`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
