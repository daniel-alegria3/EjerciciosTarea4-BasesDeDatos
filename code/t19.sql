--- \skiplines{1}

--- \item Relación de comunidades cuyos montos totales de préstamo hayan disminuido
--- en los dos últimos años, es decir, el monto total del 2003 sea menor al del
--- 2002 y el monto total del 2002 sea menor al del 2001.

--- \begin{minted}[breaklines]{sql}
WITH
P1 as (
    SELECT P.CodPrestatario, P.DocPrestamo, SUM(P.Importe) as MontoPrestamo
    FROM Prestamo P
    GROUP BY P.DocPrestamo, P.FechaPrestamo
    HAVING P.FechaPrestamo BETWEEN "01/01/2001" AND "31/12/2001"
),
P2 as (
    SELECT P.CodPrestatario, P.DocPrestamo, SUM(P.Importe) as MontoPrestamo
    FROM Prestamo P
    GROUP BY P.DocPrestamo, P.FechaPrestamo
    HAVING P.FechaPrestamo BETWEEN "01/01/2002" AND "31/12/2002"
),
P3 as (
    SELECT P.CodPrestatario, P.DocPrestamo, SUM(P.Importe) as MontoPrestamo
    FROM Prestamo P
    GROUP BY P.DocPrestamo, P.FechaPrestamo
    HAVING P.FechaPrestamo BETWEEN "01/01/2003" AND "31/12/2003"
),

Q1 as (
    SELECT C.CodComunidad, SUM(IsNull(MontoPrestamo,0)) as MontoTotalPrestamo
    FROM Comunidad C inner join T1 on C.CodPrestatario = T1.CodPrestatario
    GROUP BY C.CodComunidad
),
Q2 as (
    SELECT C.CodComunidad, SUM(IsNull(MontoPrestamo,0)) as MontoTotalPrestamo
    FROM Comunidad C inner join T2 on C.CodPrestatario = T2.CodPrestatario
    GROUP BY C.CodComunidad
),
Q3 as (
    SELECT C.CodComunidad, SUM(IsNull(MontoPrestamo,0)) as MontoTotalPrestamo
    FROM Comunidad C inner join T3 on C.CodPrestatario = T3.CodPrestatario
    GROUP BY C.CodComunidad
),

R1 as (
    SELECT C.CodComunidad, Q3.MontoTotalPrestamo
    FROM Q3 inner join Q2 on Q3.CodComunidad = Q2.CodComunidad
    WHERE Q3.MontoTotalPrestamo < Q2.MontoTotalPrestamo
),
R2 as (
    SELECT C.CodComunidad, Q2.MontoTotalPrestamo
    FROM Q2 inner join Q1 on Q2.CodComunidad = Q1.CodComunidad
    WHERE Q2.MontoTotalPrestamo < Q1.MontoTotalPrestamo
),
R3 as (
    SELECT C.CodComunidad
    FROM R1 inner join R2 on R1.CodComunidad = R2.CodComunidad
    WHERE R1.MontoTotalPrestamo < R2.MontoTotalPrestamo
)

exec cr_CompletarComunidades R3;
go
--- \end{minted}

