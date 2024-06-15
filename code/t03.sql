--- \skiplines{}
--- \item Relación de prestatarios que hasta la fecha hayan efectuado más de 5
--- préstamos.

--- \begin{minted}[breaklines]{sql}
WITH
R (CodPrestatario) as (
    SELECT Pio.CodPrestatario
    FROM Prestatario Pio inner join Prestamo Pmo on Pio.CodPrestatario = Pmo.CodPrestatario
    GROUP BY Pio.CodPrestatario
    HAVING COUNT(Pmo.DocPrestamo) > 5
)
exec cr_CompletarPrestatarios R;
go
--- \end{minted}

