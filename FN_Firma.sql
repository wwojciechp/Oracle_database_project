create or replace function FN_Firma return opakowanie.tablica PIPELINED is
cursor kursorek is 
    select w.Id_Wykonawcy, w.Nazwa_Firmy, 
            (select sum(um.Kwota)
                from Umowa um
                join Wykonawca wy on wy.Id_Wykonawcy = um.Id_Wykonawcy
            where w.Id_Wykonawcy = wy.Id_Wykonawcy)
    from Wykonawca w
        join Umowa u on w.Id_Wykonawcy = u.Id_Wykonawcy     
    group by w.Id_Wykonawcy, w.Nazwa_Firmy
    order by 1;
w opakowanie.wiersz;
begin 
open kursorek;
    loop
        fetch kursorek into w;
        exit when kursorek%notfound;
        pipe row(w);
    end loop;
close kursorek;
return;
end;


--select * from table(FN_Firma());







