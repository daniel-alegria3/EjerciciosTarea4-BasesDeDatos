--- \skiplines{1}
--- \item Relación de oficiales de crédito con los saldos totales de los préstamos
--- efectuados por ellos que están en riesgo.

--- \begin{minted}[breaklines]{sql}
WITH
R1 as (
    SELECT P.CodOficial, P.DocPrestamo, (SUM(P.Importe) - SUM(IsNull(A.Importe, 0))) as SaldoEnRiesgo
    FROM Prestamo P left outer join Amortizacion A on P.DocPrestamo = A.DocPrestamo
    GROUP BY P.DocPrestamo
    HAVING ( SUM(P.Importe) - SUM(IsNull(A.Importe, 0)) ) > 0 and
             DateDiff(month, GetDate(), P.FechaVencimiento ) > -6
),
R2 as (
    SELECT O.CodOficial, SUM(IsNull(SaldoEnRiesgo,0)) as SaldoTotalEnRiesgo
    FROM Oficial O inner join R1 on O.CodOficial = R1.CodOficial
    GROUP BY C.CodOficial
)
exec cr_CompletarOficiales R2;
go
--- \end{minted}

