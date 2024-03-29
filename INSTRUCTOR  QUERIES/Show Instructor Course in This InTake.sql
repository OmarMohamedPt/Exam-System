--INS CRS IN THIS INTAKE
CREATE OR ALTER PROCEDURE ins_crs_this_intake @id int, @year varchar(20) 
as
begin
	if exists(select 1 from Instructor where Ins_Id= @id)
		begin 
			if exists(select 1 from Course where Ins_Id = @id)
				 begin 	
					if exists(select 1 from Intake where Intake_Name=@year)
						begin
							select Ins_Name ,Crs_Name ,intake_name as Year 
							from Instructor i inner join Course c on i.Ins_Id=c.Ins_Id 
											  inner join Intake_Instructor ii on i.Ins_Id = ii.Ins_Id 
											  inner join Intake n on ii.Intake_Id = n.Intake_Id
							where  @id =i.Ins_Id and @year = n.Intake_Name
						end
					else
						RAISERROR('Invalid Instructor OR Year',10,1)
				 end
			 else
				RAISERROR('No Courses Found For This Instructor',10,1) 
		end
	else
		RAISERROR('Invalid Instructor OR Year',10,1)
end	
		
	exec	ins_crs_this_intake 4 , 2022 -- default 
	exec	ins_crs_this_intake 4 , 2025 -- correct instructor / wrong year
	exec	ins_crs_this_intake 111,2022 -- wrong instructor / correct year
	exec	ins_crs_this_intake 47 ,2022 -- instructor has no courses