module aluselct(output h,input a,input b,input c,input d,input e );

or or1(temp1,a,b);
or or2(temp2,c,d);
or or3(temp3,e,temp2);
or or4(h,temp3,temp1);

endmodule