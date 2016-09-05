﻿<?xml version="1.0" encoding="utf-8"?>
<?AutomationStudio Version=4.2.5.388?>
<SwConfiguration CpuAddress="SL1" xmlns="http://br-automation.co.at/AS/SwConfiguration">
  <TaskClass Name="Cyclic#1" />
  <TaskClass Name="Cyclic#2" />
  <TaskClass Name="Cyclic#3">
    <Task Name="pallet_mag" Source="pallett_magazine.pallet_magazine.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="pallet_con" Source="pallet_conveyors.pallet_conveyors.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="wrapper" Source="wrapper.wrapper.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#4">
    <Task Name="product_in" Source="product_infeed.product_infeed.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="robot_head" Source="robot_head.robot_head.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="robot_cont" Source="robot_control.robot_control.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="pallet_out" Source="pallet_outfeed.pallet_outfeed.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#5" />
  <TaskClass Name="Cyclic#6" />
  <TaskClass Name="Cyclic#7" />
  <TaskClass Name="Cyclic#8" />
  <Libraries>
    <LibraryObject Name="AsSafety" Source="Libraries.AsSafety.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="FileIO" Source="Libraries.FileIO.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsXml" Source="Libraries.AsXml.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="standard" Source="Libraries.standard.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="runtime" Source="Libraries.runtime.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="astime" Source="Libraries.astime.lby" Memory="UserROM" Language="Binary" Debugging="true" />
  </Libraries>
</SwConfiguration>