--- \item Relación de prestatarios morosos, es decir, aquellos que aún no han
--- cancelado alguna de sus deudas y ya pasó la fecha de vencimiento.
--- \begin{minted}[breaklines]{sql}
WITH
R (CodPrestatario) as (
    SELECT P.CodPrestatario
    FROM Prestamo P left outer join Amortizacion A on P.DocPrestamo = A.DocPrestamo
    GROUP BY P.DocPrestamo, P.CodPrestatario, P.FechaVencimiento, P.Importe
    HAVING SUM(IsNull(A.Importe, 0)) < P.Importe and GetDate() > P.FechaVencimiento
)
exec cr_CompletarPrestatarios R;
go
--- \end{minted}

