Sub Stocks()
Dim ws As Worksheet
    
For Each ws In Worksheets
'COLUMNNAMES
    ws.Cells(1, 9).Value = "Ticker"
    ws.Cells(1, 10).Value = "Total Stock Volume"
  
        Dim nameTicker As String
        Dim totalVol As Double
        totalVol = 0

    'LOCATION
        Dim rows As Long
        rows = 2
        Dim lastrow As Long
        lastrow = ws.Cells(ws.rows.Count, 1).End(xlUp).Row

    'FORLOOP
        For i = 2 To lastrow
      
        If ws.Cells(i, 1).Value <> ws.Cells(i - 1, 1).Value Then
            open1 = ws.Cells(i, 3).Value
        End If
      'VOLTOTAL
        totalVol = totalVol + ws.Cells(i, 7)
      'IFDIFFTICK
        If ws.Cells(i, 1).Value <> ws.Cells(i + 1, 1).Value Then
      'PRINTTICK&VOL
           ws.Cells(rows, 9).Value = ws.Cells(i, 1).Value
           ws.Cells(rows, 10).Value = totalVol
           rows = rows + 1
           totalVol = 0
            End If
        Next i
    lastrow = ws.Cells(ws.rows.Count, 9).End(xlUp).Row
        
    Next ws
End Sub