BEGIN{
count_cbr=0;
count_prune=0;
}
{
if($5=="cbr"){
count_cbr++;
}
if($5=="prune"){
count_prune++;
}
}
END{
printf("prune Message = %d\n",count_prune);
printf("CBR Message = %d\n",count_cbr);
}