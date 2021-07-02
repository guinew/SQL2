SELECT numero, nome, ativo
from banco;

create or replace view vw_bancos AS (
	select numero, nome, ativo
	from banco
);

select numero, nome, ativo
from vw_bancos;

create or replace view vw_bancos_2 (banco_numero, banco_nome, banco_ativo) as (
	select numero, nome, ativo
	from banco
);

select banco_numero, banco_nome, banco_ativo
from vw_bancos_2;

insert into vw_bancos_2 (banco_numero, banco_nome , banco_ativo)
values (51, 'Banco Boa Ideia Guilherme', TRUE);

select banco_numero, banco_nome, banco_ativo FROM vw_bancos_2
where banco_numero = 51

select numero, nome, ativo FROM banco where numero = 51;

update vw_bancos_2 SET banco_ativo = FALSE where banco_numero = 51;

delete from vw_bancos_2 where banco_numero = 51;


create or replace temporary view vw_agencia as (
	select nome from agencia
);

select nome from vw_agencia;


create or replace view vw_bancos_ativos as (
	select numero, nome, ativo
	from banco
	where ativo is TRUE

);

insert into vw_bancos_ativos (numero, nome, ativo) values (51, 'Banco Boa Ideia Guigui', false);

create or replace view vw_bancos_com_a as(
	select numero, nome, ativo
	from vw_bancos_ativos
	where nome ilike 'a%'
) with cascaded check option;

select numero, nome, ativo from vw_bancos_com_a;


insert into vw_bancos_com_a (numero, nome, ativo) values (333, 'Alfa Omega', true);
insert into vw_bancos_com_a (numero, nome, ativo) values (331, 'Alfa Gama', false);
insert into vw_bancos_com_a (numero, nome, ativo) values (332, 'Alfa Gama Beta', false);
insert into vw_bancos_com_a (numero, nome, ativo) values (334, 'Alfa Gama Beta2', false);




CREATE TABLE IF NOT EXISTS funcionarios (
	id serial,
	nome varchar(50),
	gerente int,
	primary key(id),
	foreign key (gerente) references funcionarios(id)
);


insert into funcionarios (nome, gerente) values ('Ancelmo', null);
insert into funcionarios (nome, gerente) values ('Beatriz', 1);
insert into funcionarios (nome, gerente) values ('Magno', 2);
insert into funcionarios (nome, gerente) values ('Cronilda', 3);
insert into funcionarios (nome, gerente) values ('Wagner', 4);


select id, nome, gerente from funcionarios where gerente is null
union all
select id, nome, gerente from funcionarios where id = 999; -- apenas para exemplificar


create or replace recursive view vw_func(id, gerente, funcionario) as (
	select id, gerente, nome 
	from funcionarios
	where gerente is null
	union all
	select funcionarios.id, funcionarios.gerente, funcionarios.nome
	from funcionarios
	join vw_func on vw_func.id = funcionarios.gerente
);


select id, gerente, funcionario
from vw_func;


select numero, nome, ativo from banco order by numero;

update banco set ativo = false where numero =0;

begin;
update banco set ativo = true where numero = 0;
select numero, nome, ativo from banco where numero =0;
rollback;

begin;
update banco set ativo = true where numero = 0;
commit;

select id, gerente, nome 
from funcionarios;

begin;
update funcionarios set gerente = 2 where id = 3;
savepoint sf_func;
update funcionarios set gerente = null; 
rollback to sf_func;
update funcionarios set gerente = 3 where id = 5;
commit;

create or replace function func_somar(int,int)
returns int
security definer 
--returns null on null input
called on null input
language sql
as $$
	select coalesce ($1,0) + coalesce($2,100);
$$;


select func_somar(1,null);

select coalesce(null, 'daniel','digital');

----------------------------------------

create or replace function bancos_add(p_numero int, p_nome varchar, p_ativo boolean)
returns int
security invoker 
language plpgsql 
called on null input 
as $$ 
declare variavel_id int;
begin
	if p_numero is null or p_nome is null or p_ativo is null then
		return 0;
	
	end if;

	select into variavel_id numero
	from banco
	where numero = p_numero;
	
	if variavel_id is null then
		insert into banco(numero, nome, ativo)
		values (p_numero, p_nome, p_ativo);
	else
		return variavel_id;
		end if;
		
		select into variavel_id numero
		from banco
		where numero = p_numero;
		
	return variavel_id;
end; $$;


select bancos_add(5433,'BancoNovo em outra porta', true);

select numero, nome, ativo from banco where numero = 5433;

