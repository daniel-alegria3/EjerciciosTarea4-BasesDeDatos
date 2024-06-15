--- \skiplines{1}
--- \item Relación de comunidades con los saldos totales de los préstamos que están en riesgo.

--- \begin{minted}[breaklines]{sql}
WITH
R1 (CodPrestatario, DocPrestamo, SaldoEnRiesgo) as (
    -- Prestatarios en riesgo
    SELECT P.CodPrestatario, P.DocPrestamo, (SUM(P.Importe) - SUM(IsNull(A.Importe, 0))) as SaldoEnRiesgo
    FROM Prestamo P left outer join Amortizacion A on P.DocPrestamo = A.DocPrestamo
    GROUP BY P.DocPrestamo
    HAVING ( SUM(P.Importe) - SUM(IsNull(A.Importe, 0)) ) > 0 and
             DateDiff(month, GetDate(), P.FechaVencimiento ) > -6
),
R2 (CodComunidad, SaldoTotalEnRiesgo) as (
    -- Comunidades con Saldos Totales
    SELECT C.CodComunidad, SUM(IsNull(SaldoEnRiesgo,0)) as SaldoTotalEnRiesgo
    FROM Comunidad C inner join R1 on C.CodPrestatario = R1.CodPrestatario
    GROUP BY C.CodComunidad
)
exec cr_CompletarComunidades R2;
go
--- \end{minted}


