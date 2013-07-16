<?php
define('FPDF_FONTPATH','font/');
include_once('includes/fpdf/fpdf.php');
include_once('includes/orbital_lib.php');
include_once('performance_profiler_lib.php');

class SALES_REPORT extends FPDF
{
   //Page header
   function Header()
   {
      $this->SetFillColor(0,82,155);
      //$this->SetFillColor(200,220,255);
      //$this->Rect(0, 0,  170, 10, "F");

      $this->Image('images/od_logo_large.jpg', 5, 1, 45);
      //$this->SetTextColor(255,255,255);
      $this->SetFont('Arial','B',20);
      $this->Text(120, 12, 'WAN Optimization Report');
   }

   function AddTableHeader($Value){
      $this->SetFont('Arial','',14);
      $this->SetLeftMargin(15);
      $this->SetDrawColor(0,0,0);
      $this->SetLineWidth(1);
      
      $this->SetFillColor(0, 0, 0);
      $this->SetTextColor(0);
      $this->SetFont('Arial','B');
      $this->SetFontSize(16);
      $this->Cell(180, 7, $Value, 'B', 1, 'C', 0);
      
      //$this->SetDrawColor(0,0,0);
      //$this->Line(15, 7, 300, 70);
   }


   function AddTableRow($Name, $Value, $Filled){
      $this->SetFont('Arial','',14);
      $this->SetLeftMargin(15);

      $this->SetFillColor(224, 230, 232);
      $this->SetTextColor(0);
      $this->SetDrawColor(128,0,0);
      $this->SetLineWidth(.3);
      $this->SetFont('Arial','');
      $this->Cell(100, 7, $Name, 0, 0, 'L', $Filled);
      $this->Cell(80, 7, $Value, 0, 0, 'R', $Filled);

      $this->Ln();
   }

   //
   // Page one includes the uncompressed/compressed bytes breakdown
   // by traffic.
   //
   function PageThreeGraphs($Bidirectional){
      $GraphDisplayDuration = GetParameter("UI.Graph.Duration");
      
      if ($GraphDisplayDuration == "minute"){
         $GraphName = "LastMinute";
      }else if ($GraphDisplayDuration == "hour"){
         $GraphName = "LastHour";
      } else{
         $GraphName = "LastDay";
      }

      
      if ($Bidirectional){
         $this->Image('temp/' . $GraphName . "(Outbound).png", 30, 30, 150, 75);
         $this->Image('temp/' . $GraphName . "(Inbound).png", 30, 160, 150, 75);
      }else{
         $this->Image('temp/' . $GraphName . ".png", 30, 30, 150, 75);
      }
   }

   //
   // Page two includes
   //
   function PageTwoGraphs(){
      $this->Image('temp/service_class_line_util_graph.png', 30, 30, 150, 75);
      $this->Image('temp/compression_bar_graph.png', 25, 120);
   }

   //Page footer
   function Footer()
   {
      //Position at 1.5 cm from bottom
      $this->SetY(-15);
      //Arial italic 8
      $this->SetFont('Arial','I',8);
      //Page number
      $this->Cell(0,10,'Page '.$this->PageNo().'/{nb}',0,0,'C');
   }
}

   //

   //
   // Create the PDF document
   //
   $pdf=new SALES_REPORT();
   $pdf->SetCreator("Orbital Data");
   $pdf->SetTitle("Orbital Data Performance Report");
   $pdf->AliasNbPages();

   //
   // Page 1 - Most stats are listed here
   //

   $pdf->AddPage();
   
   $LANIPs = GetParameter("Simulator.LANIPs");
   $Bidirectional = (sizeof($LANIPs) != 0);

   $pdf->Ln(10);
   $pdf->AddTableHeader("Summary Data");
   $pdf->AddTableRow("Generated On",        strftime ("%b %d, %Y %H:%M:%S"), true);
   $pdf->AddTableRow("Running Time",        ToPrintableTime($TimeSincePerfCounterReset), false);
   $pdf->AddTableRow("Bytes Transfered",    FormatBytes($TotalBytesXfered), true);
   $pdf->AddTableRow("Compression Ratio",   $TotalCompRatio, false);
   $pdf->AddTableRow("Line Capacity With TotalTransport",   FormatThroughput($TTSpeed), true);

   if ($Bidirectional){
      $pdf->Ln(10);
      $pdf->AddTableHeader("Outbound Traffic (LAN to WAN)");
      $pdf->AddTableRow("Uncompressed Bytes Transfered", FormatBytes($UncompBytesSent), true);
      $pdf->AddTableRow("Compressed Bytes Transfered",   FormatBytes($CompBytesSent), false);
      $pdf->AddTableRow("Compression Ratio",             $CompRatioSent, true);
      $pdf->AddTableRow("Uncompressed Line Usage",       FormatThroughput($UncompAvgLineSpeedSent), false);
      $pdf->AddTableRow("Compressed Line Usage",         FormatThroughput($CompAvgLineSpeedSent), true);
      
      $pdf->Ln(10);
      $pdf->AddTableHeader("Inbound Traffic (WAN to LAN)");
      $pdf->AddTableRow("Uncompressed Bytes Transfered", FormatBytes($UncompBytesRecv), true);
      $pdf->AddTableRow("Compressed Bytes Transfered",   FormatBytes($CompBytesRecv), false);
      $pdf->AddTableRow("Compression Ratio",             $CompRatioRecv, true);
      $pdf->AddTableRow("Compressed Line Usage",         FormatThroughput($UncompAvgLineSpeedRecv), false);
      $pdf->AddTableRow("Uncompressed Line Usage",       FormatThroughput($CompAvgLineSpeedRecv), true);      
      
      $pdf->Image('temp/compression_network_diagram.png', 30, 180, 150, 75);        
   }else{
      $pdf->AddTableRow("Uncompressed Bytes Transfered:", FormatBytes($UncompBytesSent), true);
      $pdf->AddTableRow("Compressed Bytes Transfered:",   FormatBytes($CompBytesSent), false);
      $pdf->AddTableRow("Uncompressed Line Usage:",       FormatThroughput($UncompAvgLineSpeedSent), false);
      $pdf->AddTableRow("Compressed Line Usage:",         FormatThroughput($CompAvgLineSpeedSent), true);
      
      $pdf->Image('temp/compression_network_diagram.png', 30, 180, 150, 75);
   }
      

   //
   // Page 3 - Service class break down and performance improvement with Orbital
   //
   $pdf->AddPage();
   $pdf->SetFont('Times','',12);
   $pdf->PageTwoGraphs();
   
   //
   // Page 2 - Line usage over time
   //
   $pdf->AddPage();
   $pdf->SetFont('Times','',12);
   $pdf->PageThreeGraphs($Bidirectional);



   $pdf->Output("OrbitalPerformanceReport.pdf", "I");

?>
