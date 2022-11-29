--Only highlighting JSON

MYSQL also allow to store JSON Data type 
 JavaScript object Notation (lightweight data interchange format)


Note Json column cant be index directly because it first need to extract the 
scalar value from the JSON column

@USE-CASE
Suppose we are creating a web application and want to save a users
configurations or preferences in the table. Generally, we used to 
create a separate table that contains user_id, key, and value fields 
or saves it as a formatted string so that it can be parsed at runtime. 
This method is good for limited users. 


CREATE TABLE events(   
  event_id INT AUTO_INCREMENT PRIMARY KEY,   
  event_name varchar(75),   
  visitors varchar(25),   
  properties json,   
  browser_name json  
);  


INSERT INTO events (event_name, visitors, properties, browser_name)   
VALUES (  
  'page-view',   
   '2',  
   '{"page": "/"}',  
   '{ "name": "Google Chrome", "OS": "Windows", "resolution": {"x": 1920, "y": 1080} }'  
),  
('page-view',   
  '3',  
  '{"page": "/products"}',  
  '{ "name": "Safari", "OS": "UNIX", "resolution": {"x": 2560, "y": 1600} }'  
),  
(  
  'page-view',   
  '1',  
  '{"page": "/contacts"}',  
  '{ "name": "Mozilla Firefox", "OS": "Mac", "resolution": {"x": 1920, "y": 1080} }'  
),  
(  
  'purchase',   
  '4',  
  '{"amount": 400}',  
  '{ "name": "Mozilla Firefox", "OS": "Windows", "resolution": {"x": 1280, "y": 800} }'  
);  


SELECT event_id, browser_name->'$.name' AS browser FROM events; 
SELECT event_id, browser_name->>'$.name' AS browser FROM events;
