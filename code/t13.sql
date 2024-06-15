--- \skiplines{1}
--- \item Relación de los oficiales de crédito estrella de cada mes del año 2003.
--- (Se considera oficial de crédito “estrella” del mes, al oficial de crédito
--- que haya colocado el mayor número de préstamos en el mes)

--- \begin{minted}[breaklines]{sql}
WITH
MEJORES as (
    SELECT DATEPART(month, P.FechaPrestamo) as Mes, O.CodOficial
    FROM Oficial O inner join Prestamo P on O.CodOficial = P.CodOficial
    WHERE DATEPART(year, P.FechaPrestamo) = 2003
),
R as (
    SELECT M.Mes, M.CodOficial
    FROM MEJORES M
    WHERE M.CodOficial in (
        select top(1) m.CodOficial
        from MEJORES m
        where m.Mes = M.Mes and m.CodOficial = M.CodOficial
        order by m.CodOficial desc
    )
    GROUP BY DATEPART(month, P.FechaPrestamo), O.CodOficial
    HAVING DATEPART(year, P.FechaPrestamo) = 2003
)

exec cr_CompletarOficiales R;
go
--- \end{minted}

