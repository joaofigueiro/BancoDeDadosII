

CREATE OR REPLACE FUNCTION insertData(id int, name varchar(50), birth_year int, salary float)
RETURNS void AS
  $$
  DECLARE  
    BEGIN 
        INSERT INTO employee (id, name, birth_year, salary, dh_inicio_registro, nm_user) VALUES (id, name, birth_year, salary, current_date, current_user); 
     END;
  $$ 
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION delete_employee_higher_average_salary()
RETURNS void AS
  $$
  DECLARE  
     BEGIN 
        DELETE FROM employee WHERE salary > (SELECT AVG(salary) AS salary FROM employee); 
     END;
  $$ 
LANGUAGE plpgsql; 

CREATE OR REPLACE FUNCTION increase_greater_than(increase_percentage float, base_id int)
RETURNS void AS
  $$
  DECLARE  
     BEGIN 
        UPDATE employee SET salary = round(salary * (1+increase_percentage)) WHERE id > base_id; 
     END;
  $$ 
LANGUAGE plpgsql; 
