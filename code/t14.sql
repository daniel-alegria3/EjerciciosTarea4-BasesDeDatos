--- \skiplines{1}

--- \item Relación de oficiales de crédito que no hayan colocado por lo menos un
--- préstamo en algún mes del año 2003.

--- \begin{minted}[breaklines]{sql}
WITH
R as (
    SELECT O.CodOficial
    FROM Oficial O left outer join Prestamo P on O.CodOficial = P.CodOficial
    WHERE P.FechaPrestamo BETWEEN "01/01/2003" AND "12/31/2003"
    GROUP BY O.CodOficial
    HAVING COUNT(P.DocPrestamo) < 1
)
exec cr_CompletarOficiales R;
go
--- \end{minted}

