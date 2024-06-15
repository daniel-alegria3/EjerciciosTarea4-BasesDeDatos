--- \skiplines{1}
--- \item Relación de comunidades que no tengan prestatarios morosos

--- \begin{minted}[breaklines]{sql}
WITH
R1 (CodPrestatario) as (
    SELECT P.CodPrestatario
    FROM Prestamo P left outer join Amortizacion A on P.DocPrestamo = A.DocPrestamo
    GROUP BY P.DocPrestamo, P.CodPrestatario, P.FechaVencimiento
    HAVING SUM(IsNull(A.Importe, 0)) < SUM(P.Importe) and GetDate() > P.FechaVencimiento
),
R2 (CodComunidad) as (
    SELECT P.CodComunidad
    FROM Prestatario P, R1
    WHERE P.CodPrestatario = R1.CodPrestatario
),
R3 (CodComunidad) as (
    SELECT CodComunidad
    FROM R1
    EXCEPT
    SELECT CodComunidad
    FROM R2
)
exec cr_CompletarComunidades R2;
go
--- \end{minted}

