BEGIN {
    recvdPkts = 0
    transPkts = 0
    startTime = 400
    stopTime = 0
    tput=0
}

{
    event = $1
    time = $2
    send_id = $3
    rec_id = $4
    pkt_size = $6
    flow_id = $8

    # Store start time
    if (send_id == "0"||send_id == "1"||send_id == "2" ) {
        if (time < startTime) {
            startTime = time
        }

        if (event == "+") {
            # Store transmitted packet's size
            transPkts++
        }
    }

    # Update total received packets' size and store packets arrival time
    if ((event == "r") && (rec_id == "10" || rec_id == "12" ||  rec_id == "13" ||  rec_id == "14" || rec_id == "3" || rec_id == "11" || rec_id == "5" || rec_id == "6" || rec_id == "7" || rec_id == "8" || rec_id == "9")) {
        if (time > stopTime) {
            stopTime = time
        }
        # Store received packet's size
        if (flow_id == "1"||flow_id == "2"||flow_id == "3") {
            recvdPkts++
        }
    }
}

END {
    printf("%i %i\n", transPkts, recvdPkts )
    #tput=recvdPkts/(stopTime-startTime)
    #printf("Received packets per sec: %d\n",tput)
}