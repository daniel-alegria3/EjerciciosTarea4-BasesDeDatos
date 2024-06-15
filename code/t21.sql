--- \skiplines{1}
--- \item Relación de préstamos colocados por comunidad, para los años 2000, 2001,
--- 2002 y 2003, con la siguiente información:
--- R(CodComunidad,NombreComunidad,Total2000,Total2001,Total2002,Total2003)

--- \begin{minted}[breaklines]{sql}
WITH
T as (
    SELECT Pio.CodComunidad, Pmo.CodPrestatario, Pmo.DocPrestamo, Pmo.FechaPrestamo
    FROM Prestamo Pmo left outer join Prestatario Pio on Pmo.CodPrestatario = Pio.CodPrestatario
),

Q0 as (
    SELECT C.CodComunidad, COUNT(T.DocPrestamo) as Total2000
    FROM Comunidad C left outer join T on C.CodComunidad = T.CodComunidad
    GROUP BY T.CodComunidad
    HAVING DATEPART(year, T.FechaPrestamo) = 2000
),
Q1 as (
    SELECT C.CodComunidad, COUNT(T.DocPrestamo) as Total2001
    FROM Comunidad C left outer join T on C.CodComunidad = T.CodComunidad
    GROUP BY T.CodComunidad
    HAVING DATEPART(year, T.FechaPrestamo) = 2001
),
Q2 as (
    SELECT C.CodComunidad, COUNT(T.DocPrestamo) as Total2002
    FROM Comunidad C left outer join T on C.CodComunidad = T.CodComunidad
    GROUP BY T.CodComunidad
    HAVING DATEPART(year, T.FechaPrestamo) = 2002
),
Q3 as (
    SELECT C.CodComunidad, COUNT(T.DocPrestamo) as Total2003
    FROM Comunidad C left outer join T on C.CodComunidad = T.CodComunidad
    GROUP BY T.CodComunidad
    HAVING DATEPART(year, T.FechaPrestamo) = 2003
),

R as (
    SELECT Q0.CodComunidad, Q0.Total2000, Q1.Total2001, Q2.Total2002, Q3.Total2003
    FROM Q0, Q1, Q2, Q3
    WHERE Q0.CodComunidad = Q1.CodComunidad = Q2.CodComunidad = Q3.CodComunidad
    ORDER BY Q0.CodComunidad
)

SELECT C.NombreComunidad, R.*
FROM Comunidad C inner join R on C.CodComunidad = R.CodComunidad;
go
--- \end{minted}

