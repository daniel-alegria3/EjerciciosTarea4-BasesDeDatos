--- \item Relación de préstamos cancelados de un determinado prestatario.
--- \begin{minted}[breaklines]{sql}
WITH R(CodPrestatario, DocPrestamo) as (
    SELECT P.CodPrestatario, P.DocPrestamo
    FROM Prestamo P left outer join Amortizacion A on P.DocPrestamo = A.DocPrestamo
    GROUP BY P.CodPrestatario, P.DocPrestamo
    HAVING SUM(P.Importe) = SUM(IsNull(A.Importe, 0))
)
exec cr_CompletarPrestamos R;
go
--- \end{minted}

