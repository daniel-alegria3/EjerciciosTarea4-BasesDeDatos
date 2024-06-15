--- \skiplines{1}
--- \item Relación de préstamos colocados por comunidad, para los meses del año 2003,
--- con la siguiente información:
--- R(CodComunidad,NombreComunidad,TotalEnero,TotalFebrero, …, TotalDiciembre)

--- \begin{minted}[breaklines]{sql}
WITH
T as (
    SELECT Pio.CodComunidad, Pmo.CodPrestatario, Pmo.DocPrestamo, Pmo.FechaPrestamo
    FROM Prestamo Pmo left outer join Prestatario Pio on Pmo.CodPrestatario = Pio.CodPrestatario
),

Q1 as (
    SELECT C.CodComunidad, COUNT(T.DocPrestamo) as TotalMes1
    FROM Comunidad C left outer join T on C.CodComunidad = T.CodComunidad
    GROUP BY T.CodComunidad
    HAVING DATEPART(year, T.FechaPrestamo) = 2003 and DATEPART(month, T.FechaPrestamo) = 1
),
Q2 as (
    SELECT C.CodComunidad, COUNT(T.DocPrestamo) as TotalMes2
    FROM Comunidad C left outer join T on C.CodComunidad = T.CodComunidad
    GROUP BY T.CodComunidad
    HAVING DATEPART(year, T.FechaPrestamo) = 2003 and DATEPART(month, T.FechaPrestamo) = 2
),
Q3 as (
    SELECT C.CodComunidad, COUNT(T.DocPrestamo) as TotalMes3
    FROM Comunidad C left outer join T on C.CodComunidad = T.CodComunidad
    GROUP BY T.CodComunidad
    HAVING DATEPART(year, T.FechaPrestamo) = 2003 and DATEPART(month, T.FechaPrestamo) = 3
),
Q4 as (
    SELECT C.CodComunidad, COUNT(T.DocPrestamo) as TotalMes4
    FROM Comunidad C left outer join T on C.CodComunidad = T.CodComunidad
    GROUP BY T.CodComunidad
    HAVING DATEPART(year, T.FechaPrestamo) = 2003 and DATEPART(month, T.FechaPrestamo) = 4
),
Q5 as (
    SELECT C.CodComunidad, COUNT(T.DocPrestamo) as TotalMes5
    FROM Comunidad C left outer join T on C.CodComunidad = T.CodComunidad
    GROUP BY T.CodComunidad
    HAVING DATEPART(year, T.FechaPrestamo) = 2003 and DATEPART(month, T.FechaPrestamo) = 5
),
Q6 as (
    SELECT C.CodComunidad, COUNT(T.DocPrestamo) as TotalMes6
    FROM Comunidad C left outer join T on C.CodComunidad = T.CodComunidad
    GROUP BY T.CodComunidad
    HAVING DATEPART(year, T.FechaPrestamo) = 2003 and DATEPART(month, T.FechaPrestamo) = 6
),
Q7 as (
    SELECT C.CodComunidad, COUNT(T.DocPrestamo) as TotalMes7
    FROM Comunidad C left outer join T on C.CodComunidad = T.CodComunidad
    GROUP BY T.CodComunidad
    HAVING DATEPART(year, T.FechaPrestamo) = 2003 and DATEPART(month, T.FechaPrestamo) = 7
),
Q8 as (
    SELECT C.CodComunidad, COUNT(T.DocPrestamo) as TotalMes8
    FROM Comunidad C left outer join T on C.CodComunidad = T.CodComunidad
    GROUP BY T.CodComunidad
    HAVING DATEPART(year, T.FechaPrestamo) = 2003 and DATEPART(month, T.FechaPrestamo) = 8
),
Q9 as (
    SELECT C.CodComunidad, COUNT(T.DocPrestamo) as TotalMes9
    FROM Comunidad C left outer join T on C.CodComunidad = T.CodComunidad
    GROUP BY T.CodComunidad
    HAVING DATEPART(year, T.FechaPrestamo) = 2003 and DATEPART(month, T.FechaPrestamo) = 9
),
Q10 as (
    SELECT C.CodComunidad, COUNT(T.DocPrestamo) as TotalMes10
    FROM Comunidad C left outer join T on C.CodComunidad = T.CodComunidad
    GROUP BY T.CodComunidad
    HAVING DATEPART(year, T.FechaPrestamo) = 2003 and DATEPART(month, T.FechaPrestamo) = 10
),
Q11 as (
    SELECT C.CodComunidad, COUNT(T.DocPrestamo) as TotalMes11
    FROM Comunidad C left outer join T on C.CodComunidad = T.CodComunidad
    GROUP BY T.CodComunidad
    HAVING DATEPART(year, T.FechaPrestamo) = 2003 and DATEPART(month, T.FechaPrestamo) = 11
),
Q12 as (
    SELECT C.CodComunidad, COUNT(T.DocPrestamo) as TotalMes12
    FROM Comunidad C left outer join T on C.CodComunidad = T.CodComunidad
    GROUP BY T.CodComunidad
    HAVING DATEPART(year, T.FechaPrestamo) = 2003 and DATEPART(month, T.FechaPrestamo) = 12
)

R as (
    SELECT Q0.CodComunidad, Q1.TotalMes1, Q2.TotalMes2, Q3.TotalMes3, Q4.TotalMes4,
                            Q5.TotalMes5, Q6.TotalMes6, Q7.TotalMes7, Q8.TotalMes8,
                            Q9.TotalMes9, Q10.TotalMes10, Q11.TotalMes11, Q12.TotalMes12
    FROM Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12
    WHERE Q1.CodComunidad = Q2.CodComunidad = Q3.CodComunidad = Q4.CodComunidad =
          Q5.CodComunidad = Q6.CodComunidad = Q7.CodComunidad = Q8.CodComunidad =
          Q9.CodComunidad = Q10.CodComunidad = Q11.CodComunidad = Q12.CodComunidad
    ORDER BY Q0.CodComunidad
)

SELECT C.NombreComunidad, R.*
FROM Comunidad C inner join R on C.CodComunidad = R.CodComunidad
go
--- \end{minted}

--- \skiplines{1}
-- Tal vez la pregunta no debio haber especificado las entradas "TotalX"?
-- ALTERNATIVAMENTE:
--- \begin{minted}[breaklines]{sql}
WITH
T as (
    SELECT Pio.CodComunidad, Pmo.CodPrestatario, Pmo.DocPrestamo, Pmo.FechaPrestamo
    FROM Prestamo Pmo left outer join Prestatario Pio on Pmo.CodPrestatario = Pio.CodPrestatario
),
R as (
    SELECT C.CodComunidad, DATEPART(month, T.FechaPrestamo) as Mes, COUNT(T.DocPrestamo) as NroPrestamos
    FROM Comunidad C left outer join T on C.CodComunidad = T.CodComunidad
    GROUP BY T.CodComunidad, DATEPART(month, T.FechaPrestamo)
    HAVING DATEPART(year, T.FechaPrestamo) = 2003
),

SELECT C.NombreComunidad, R.*
FROM Comunidad C inner join R on C.CodComunidad = R.CodComunidad
go
--- \end{minted}

