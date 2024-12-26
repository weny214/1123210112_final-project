module final(DATA_R, DATA_G, DATA_B, COMM, a, b, c, d, e, f, g, CLK, left, right, speed, rotation, clear, timeout);
    output reg [7:0] DATA_R, DATA_G, DATA_B;
    output reg [3:0] COMM;
    output reg a, b, c, d, e, f, g;
    input CLK, left, right, speed, rotation, clear, timeout;
    
    integer test = 0, origin = 1, gg = 0, score = 0, rotationtime, find, fivetime = 0, color = 0, randomnum = 0, n, n1, n2, n3,i;
    
    reg [7:0] one[7:0];
    reg [7:0] two[7:0];
    reg [7:0] three[7:0];
    reg [7:0] four[7:0];
    reg [7:0] five[7:0];
    reg [7:0] six[7:0];
    reg [7:0] seven[7:0];
    reg [7:0] start[7:0];
    reg [7:0] zero[7:0];
    reg [7:0] xx[7:0];
    reg [7:0] tmp[7:0];
    reg [7:0] now[7:0];
    reg [7:0] R[7:0];
    reg [7:0] G[7:0];
    reg [7:0] B[7:0];
    reg [2:0] cnt, num;
    
    // 分頻模組例化
    divfreq_1 div1(CLK_div_1, CLK);
    divfreq_2 div2(CLK_div_2, CLK);

    // 初始化
    initial begin
        cnt = 0;
        DATA_R = 8'b11111111;
        DATA_G = 8'b11111111;
        DATA_B = 8'b11111111;
        COMM = 4'b1000;
        
        // 初始化圖案
        one[0] = 8'b11111111; one[1] = 8'b11111111; one[2] = 8'b11111111; one[3] = 8'b11111100;//正方型
        one[4] = 8'b11111100; one[5] = 8'b11111111; one[6] = 8'b11111111; one[7] = 8'b11111111;

        two[0] = 8'b11111111; two[1] = 8'b11111111; two[2] = 8'b11111110; two[3] = 8'b11111110;//一條線
        two[4] = 8'b11111110; two[5] = 8'b11111110; two[6] = 8'b11111111; two[7] = 8'b11111111;

        three[0] = 8'b11111111; three[1] = 8'b11111111; three[2] = 8'b11111111; three[3] = 8'b11111101;//左閃電
        three[4] = 8'b11111100; three[5] = 8'b11111110; three[6] = 8'b11111111; three[7] = 8'b11111111;

        four[0] = 8'b11111111; four[1] = 8'b11111111; four[2] = 8'b11111110; four[3] = 8'b11111100;//右閃電
        four[4] = 8'b11111101; four[5] = 8'b11111111; four[6] = 8'b11111111; four[7] = 8'b11111111;

        five[0] = 8'b11111111; five[1] = 8'b11111111; five[2] = 8'b11111111; five[3] = 8'b11111110;//左勺子
        five[4] = 8'b11111110; five[5] = 8'b11111100; five[6] = 8'b11111111; five[7] = 8'b11111111;

        six[0] = 8'b11111111; six[1] = 8'b11111111; six[2] = 8'b11111100; six[3] = 8'b11111110;//右勺子
        six[4] = 8'b11111110; six[5] = 8'b11111111; six[6] = 8'b11111111; six[7] = 8'b11111111;

        seven[0] = 8'b11111111; seven[1] = 8'b11111111; seven[2] = 8'b11111111; seven[3] = 8'b11111110;//十字架
        seven[4] = 8'b11111100; seven[5] = 8'b11111110; seven[6] = 8'b11111111; seven[7] = 8'b11111111;

        start[0] = 8'b01111110; start[1] = 8'b00000000; start[2] = 8'b01111110; start[3] = 8'b11111111;//開始
        start[4] = 8'b00000000; start[5] = 8'b11110111; start[6] = 8'b11110111; start[7] = 8'b00000000;

        zero[0] = 8'b11111111; zero[1] = 8'b11111111; zero[2] = 8'b11111111; zero[3] = 8'b11111111;//歸零
        zero[4] = 8'b11111111; zero[5] = 8'b11111111; zero[6] = 8'b11111111; zero[7] = 8'b11111111;

        xx[0] = 8'b01111110; xx[1] = 8'b10111101; xx[2] = 8'b11011011; xx[3] = 8'b11100111;//右勺子
        xx[4] = 8'b11100111; xx[5] = 8'b11011011; xx[6] = 8'b10111101; xx[7] = 8'b01111110;
    end

    // 時序邏輯
    always @(posedge CLK_div_2) //下降
	 begin
       //DATA_R = xx[cnt];
		  
		  if (clear == 1'b1) 
		  begin
            now[0] = 0; now[1] = 0; now[2] = 0; now[3] = 0; // 將狀態歸零
		      now[4] = 0; now[5] = 0; now[6] = 0; now[7] = 0;
		      R[0] = 0; R[1] = 0; R[2] = 0; R[3] = 0; // 清除 R 資料
		      R[4] = 0; R[5] = 0; R[6] = 0; R[7] = 0;
		      G[0] = 0; G[1] = 0; G[2] = 0; G[3] = 0; // 清除 G 資料
		      G[4] = 0; G[5] = 0; G[6] = 0; G[7] = 0;
            B[0] = 0; B[1] = 0; B[2] = 0; B[3] = 0; // 清除 B 資料
		      B[4] = 0; B[5] = 0; B[6] = 0; B[7] = 0;
            origin <= 1'b1;   // 將 origin 設為 1
            gg <= 1'b0;       // 遊戲進行中，未結束
            score <= 0;       // 分數歸零
            fivetime <= 0;    // 五倍分數歸零
        end

		  else begin
    for(n=0;n<=speed;n=n+1)
        if(gg==0&&timeout==0)
            begin
                if(test==1||origin==1) // 到底
                    begin
                        fivetime=fivetime+1;
                        for(n1=0;n1<8;n1=n1+1) // 檢查消掉
                            begin
                                test=0;
                                for(n2=0;n2<8;n2=n2+1)
                                    if(now[n2][n1]==0)
                                        test=test+1;
                                if(test==8) // 消掉
                                    begin
                                        score=score+1;
                                        for(n2=7;n2>=0;n2=n2-1)
                                            for(n3=n1;n3>0;n3=n3-1)
                                                begin
                                                    now[n2][n3]=now[n2][n3-1];
                                                    R[n2][n3]=R[n2][n3-1];
                                                    G[n2][n3]=G[n2][n3-1];
                                                    B[n2][n3]=B[n2][n3-1];
                                                end
                                        for(n2=0;n2<8;n2=n2+1)
                                            begin
                                                now[n2][0]=1;
                                                R[n2][0]=1;
                                                G[n2][0]=1;
                                                B[n2][0]=1;
                                            end
                                    end
                            end
                        randomnum=randomnum+test;
                        case(randomnum%7) // 变换
                        0: for (i = 0; i < 8; i = i + 1) begin tmp[i] = one[i];end
                        1: for (i = 0; i < 8; i = i + 1) begin tmp[i] = two[i];end
                        2: for (i = 0; i < 8; i = i + 1) begin tmp[i] = three[i];end
                        3: for (i = 0; i < 8; i = i + 1) begin tmp[i] = four[i];end
                        4: for (i = 0; i < 8; i = i + 1) begin tmp[i] = five[i];end
                        5: for (i = 0; i < 8; i = i + 1) begin tmp[i] = six[i];end
                        6: for (i = 0; i < 8; i = i + 1) begin tmp[i] = seven[i];end
                        endcase

                        num=randomnum%7;
                        color=color+1;
                        origin=0;
                        rotationtime=0;
                    end
                else // 要繼續下降
                    begin
                        fivetime=fivetime+1;
                        for(n1=0;n1<8;n1=n1+1) // now清掉tmp
                            for(n2=0;n2<8;n2=n2+1)
                                if(tmp[n1][n2]==0)
                                    begin
                                        now[n1][n2]=1;
                                        case(color%3)
                                            0: R[n1][n2]=1;
                                            1: G[n1][n2]=1;
                                            2: B[n1][n2]=1;
                                        endcase
                                    end
                        if(fivetime%4==0)
                            begin
                                for(n1=7;n1>=0;n1=n1-1) // 下降
                                    for(n2=7;n2>0;n2=n2-1)
                                        tmp[n1][n2]=tmp[n1][n2-1];
                                for(n1=0;n1<8;n1=n1+1) // 第一排歸零
                                    tmp[n1][0]=1;
                            end
                    end
                test=1;
            end
end

					
		  if (left == 1) begin // 左移按鍵檢查
    randomnum = randomnum + 2; // 隨機數更新（假設有意義）

    // 邊界檢查：確保第一列中沒有空的方塊，否則不能左移
    test = 1;
    for (n1 = 0; n1 < 8; n1 = n1 + 1) begin
        if (tmp[0][n1] == 0) begin
            test = 0; // 無法左移
            disable move_left; // 提早退出
        end
    end

move_left: if (test == 1) begin
    // 碰撞檢查：確保下方方塊左移後不會與固定方塊重疊
    for (n1 = 1; n1 < 8; n1 = n1 + 1) begin
        for (n2 = 0; n2 < 8; n2 = n2 + 1) begin
            if (tmp[n1][n2] == 0 && now[n1 - 1][n2] == 0) begin
                test = 0;
                disable check_collision; // 提早退出檢查
            end
        end
    end

check_collision: if (test == 1) begin
    // 執行左移操作
    for (n1 = 0; n1 < 7; n1 = n1 + 1) begin
        for (n2 = 0; n2 < 8; n2 = n2 + 1) begin
            tmp[n1][n2] = tmp[n1 + 1][n2]; // 將每列左移
        end
    end

    // 補充最後一列的背景數值
    for (n1 = 0; n1 < 8; n1 = n1 + 1) begin
        tmp[7][n1] = 1; // 假設 1 是背景
    end
end
end
end
if (right == 1) 
begin // 右移按鍵檢查
    randomnum = randomnum + 2; // 隨機數更新（假設有意義）

    // 邊界檢查：確保最後一列中沒有空的方塊，否則不能右移
    test = 1;
    for (n1 = 0; n1 < 8; n1 = n1 + 1) 
	 begin
        if (tmp[7][n1] == 0) 
		  begin
            test = 0; // 無法右移
            disable move_right; // 提早退出
        end
    end

move_right: if (test == 1) 
begin
    // 碰撞檢查：確保右移後不會與固定方塊重疊
    for (n1 = 6; n1 >= 0; n1 = n1 - 1) 
	 begin
        for (n2 = 0; n2 < 8; n2 = n2 + 1) 
		  begin
            if (tmp[n1][n2] == 0 && now[n1 + 1][n2] == 0) 
				begin
                test = 0;
                disable check_collision; // 提早退出檢查
            end
        end
    end

check_collision: if (test == 1) 
begin
    // 執行右移操作
    for (n1 = 7; n1 > 0; n1 = n1 - 1) 
	 begin
        for (n2 = 0; n2 < 8; n2 = n2 + 1) 
		  begin
            tmp[n1][n2] = tmp[n1 - 1][n2]; // 將每列右移
        end
    end

    // 補充第一列的背景數值
    for (n1 = 0; n1 < 8; n1 = n1 + 1) 
	 begin
        tmp[0][n1] = 1; // 假設 1 是背景
    end
end
end
end
end
always @(posedge CLK_div_1) begin
        //DATA_R = start[cnt];
        if (cnt >= 7)
            cnt <= 0;
        else
            cnt <= cnt + 1;

        COMM <= {1'b1, cnt};

        // 數碼管顯示分數
        case (score)
            4'd0: {a, b, c, d, e, f, g} = 7'b0000001;
            4'd1: {a, b, c, d, e, f, g} = 7'b1001111;
            4'd2: {a, b, c, d, e, f, g} = 7'b0010010;
            4'd3: {a, b, c, d, e, f, g} = 7'b0000110;
            4'd4: {a, b, c, d, e, f, g} = 7'b1001100;
            4'd5: {a, b, c, d, e, f, g} = 7'b0100100;
            4'd6: {a, b, c, d, e, f, g} = 7'b0100000;
            4'd7: {a, b, c, d, e, f, g} = 7'b0001111;
            4'd8: {a, b, c, d, e, f, g} = 7'b0000000;
            4'd9: {a, b, c, d, e, f, g} = 7'b0000100;
            default: {a, b, c, d, e, f, g} = 7'b1111111;
        endcase

        // RGB 顯示邏輯
        if (clear) begin
            DATA_R <= start[cnt];
            DATA_G <= 8'b11111111;
            DATA_B <= 8'b11111111;
        end else begin
            DATA_R <= R[cnt];
            DATA_G <= G[cnt];
            DATA_B <= B[cnt];
        end
    end
endmodule

module divfreq_1(output reg CLK_div, input CLK);
    reg [24:0] Count;
    always @(posedge CLK) begin
        if (Count > 25000) begin
            Count <= 25'b0;
            CLK_div <= ~CLK_div;
        end 
		  else
            Count <= Count + 1'b1;
    end
endmodule
module divfreq_2(output reg CLK_div, input CLK);
    reg [24:0] Count;
    always @(posedge CLK) begin
        if (Count > 6250000) begin
            Count <= 25'b0;
            CLK_div <= ~CLK_div;
        end else
            Count <= Count + 1'b1;
    end
endmodule