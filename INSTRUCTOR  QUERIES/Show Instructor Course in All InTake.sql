CREATE OR ALTER PROCEDURE ins_crs_intake @id int
as 
begin
	if exists(select 1 from Instructor where Ins_Id= @id)
		begin 
			if exists(select 1 from Course where Ins_Id = @id)
				 begin 	
					select Ins_Name ,Crs_Name ,intake_name as Year 
					from Instructor i inner join Course c on i.Ins_Id=c.Ins_Id 
									  inner join Intake_Instructor ii on i.Ins_Id = ii.Ins_Id 
				 					  inner join Intake n on ii.Intake_Id = n.Intake_Id
				 	where  @id =i.Ins_Id 
				 end
	        else
				RAISERROR ('No Courses Found For This Instructor',10,1)
		end
	else
		RAISERROR('Instructor Not Found',10,1)
end	
		

exec ins_crs_intake 1 -- normal case 
exec ins_crs_intake 47 -- ins has no courses
exec ins_crs_intake 447 -- invalid id 