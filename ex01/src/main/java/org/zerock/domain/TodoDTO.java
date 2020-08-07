package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data 

public class TodoDTO
{
    private String title;
    
    
//  @DateTimeFormat(pattern = "yyyy/MM/dd")
//  Controller의 @InitBinder 대신 사용 가능
  private Date dueDate;
}
