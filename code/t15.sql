--- \skiplines{1}
--- \item Relación de préstamos en riesgo. Se considera un préstamo en riesgo cuando
--- tiene saldo y ha trascurrido más de 6 meses de su fecha de vencimiento.

--- \begin{minted}[breaklines]{sql}
WITH
R as (
    SELECT P.DocPrestamo
    FROM Prestamo P left outer join Amortizacion A on P.DocPrestamo = A.DocPrestamo
    GROUP BY P.DocPrestamo, P.FechaVencimiento
    HAVING ( SUM(P.Importe) - SUM(IsNull(A.Importe, 0)) ) > 0 and
             DateDiff(month, GetDate(), P.FechaVencimiento ) > -6
)
exec cr_CompletarPrestamos R;
go
--- \end{minted}

