/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200925 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of iASLWUCZsx.aml, Mon Nov  1 23:06:23 2021
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00000547 (1351)
 *     Revision         0x02
 *     Checksum         0xEE
 *     OEM ID           "DELL"
 *     OEM Table ID     "E7280"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20200925 (538970405)
 */
DefinitionBlock ("", "SSDT", 2, "DELL", "E7280", 0x00000000)
{
    External (_PR_.CPU0, ProcessorObj)
    External (_SB_.AC__, DeviceObj)
    External (_SB_.ACOS, IntObj)
    External (_SB_.ACSE, IntObj)
    External (_SB_.GNUM, MethodObj)    // 1 Arguments
    External (_SB_.PCI0, DeviceObj)
    External (_SB_.PCI0.GFX0, DeviceObj)
    External (_SB_.PCI0.HIDD, MethodObj)    // 5 Arguments
    External (_SB_.PCI0.HIDG, BuffObj)
    External (_SB_.PCI0.I2C1, DeviceObj)
    External (_SB_.PCI0.LPCB, DeviceObj)
    External (_SB_.PCI0.LPCB.PS2K, DeviceObj)
    External (_SB_.PCI0.SBUS, DeviceObj)
    External (_SB_.PCI0.TP7D, MethodObj)    // 6 Arguments
    External (_SB_.PCI0.TP7G, BuffObj)
    External (GPDI, FieldUnitObj)
    External (HPTE, IntObj)
    External (INT1, FieldUnitObj)
    External (SDS1, FieldUnitObj)
    External (XPRW, MethodObj)    // 2 Arguments

    Scope (\)
    {
        If (_OSI ("Darwin"))
        {
            HPTE = Zero
            SDS1 = Zero
            \_SB.ACOS = 0x80
            \_SB.ACSE = Zero
        }

        Scope (_SB)
        {
            Device (USBX)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                {
                    If ((Arg2 == Zero))
                    {
                        Return (Buffer (One)
                        {
                             0x03                                             // .
                        })
                    }

                    Return (Package (0x04)
                    {
                        "kUSBSleepPortCurrentLimit", 
                        0x0BB8, 
                        "kUSBWakePortCurrentLimit", 
                        0x0BB8
                    })
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If (_OSI ("Darwin"))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Scope (AC)
            {
                If (_OSI ("Darwin"))
                {
                    Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                    {
                        0x1C, 
                        0x03
                    })
                }
            }

            Scope (PCI0)
            {
                Device (MCHC)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If (_OSI ("Darwin"))
                        {
                            Return (0x0F)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }
                }

                Scope (SBUS)
                {
                    Device (BUS0)
                    {
                        Name (_CID, "smbus")  // _CID: Compatible ID
                        Name (_ADR, Zero)  // _ADR: Address
                        Device (DVL0)
                        {
                            Name (_ADR, 0x57)  // _ADR: Address
                            Name (_CID, "diagsvault")  // _CID: Compatible ID
                            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                            {
                                If (!Arg2)
                                {
                                    Return (Buffer (One)
                                    {
                                         0x57                                             // W
                                    })
                                }

                                Return (Package (0x02)
                                {
                                    "address", 
                                    0x57
                                })
                            }
                        }

                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            If (_OSI ("Darwin"))
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }
                    }
                }

                Scope (I2C1)
                {
                    Device (TPDX)
                    {
                        Name (HID2, Zero)
                        Name (SBFB, ResourceTemplate ()
                        {
                            I2cSerialBusV2 (0x002C, ControllerInitiated, 0x00061A80,
                                AddressingMode7Bit, "\\_SB.PCI0.I2C1",
                                0x00, ResourceConsumer, , Exclusive,
                                )
                        })
                        Name (SBFG, ResourceTemplate ()
                        {
                            GpioInt (Level, ActiveLow, ExclusiveAndWake, PullDefault, 0x0000,
                                "\\_SB.PCI0.GPI0", 0x00, ResourceConsumer, ,
                                )
                                {   // Pin list
                                    0x0000
                                }
                        })
                        CreateWordField (SBFG, 0x17, INT1)
                        Method (_INI, 0, NotSerialized)  // _INI: Initialize
                        {
                            INT1 = GNUM (GPDI)
                            HID2 = 0x20
                        }

                        Name (_HID, "DLL079F")  // _HID: Hardware ID
                        Name (_CID, "PNP0C50" /* HID Protocol Device (I2C bus) */)  // _CID: Compatible ID
                        Name (_S0W, 0x03)  // _S0W: S0 Device Wake State
                        Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
                        {
                            If ((Arg0 == HIDG))
                            {
                                Return (HIDD (Arg0, Arg1, Arg2, Arg3, HID2))
                            }

                            If ((Arg0 == TP7G))
                            {
                                Return (TP7D (Arg0, Arg1, Arg2, Arg3, SBFB, SBFG))
                            }

                            Return (Buffer (One)
                            {
                                 0x00                                             // .
                            })
                        }

                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            If (_OSI ("Darwin"))
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }

                        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                        {
                            Return (ConcatenateResTemplate (SBFB, SBFG))
                        }
                    }
                }

                Scope (GFX0)
                {
                    Device (PNLF)
                    {
                        Name (_HID, EisaId ("APP0002"))  // _HID: Hardware ID
                        Name (_CID, "backlight")  // _CID: Compatible ID
                        Name (_UID, 0x10)  // _UID: Unique ID
                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            If (_OSI ("Darwin"))
                            {
                                Return (0x0B)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }
                    }
                }

                Scope (LPCB)
                {
                    Device (EC)
                    {
                        Name (_HID, "ACID0001")  // _HID: Hardware ID
                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            If (_OSI ("Darwin"))
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }
                    }

                    Scope (PS2K)
                    {
                        If (_OSI ("Darwin"))
                        {
                            Name (RMCF, Package (0x04)
                            {
                                "Keyboard", 
                                Package (0x02)
                                {
                                    "RemapPrntScr", 
                                    ">y"
                                }, 

                                "Keyboard", 
                                Package (0x02)
                                {
                                    "Custom PS2 Map", 
                                    Package (0x03)
                                    {
                                        Package (0x00){}, 
                                        "46=0", 
                                        "e045=0"
                                    }
                                }
                            })
                        }
                    }
                }
            }
        }

        Scope (_PR)
        {
            Scope (CPU0)
            {
                Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                {
                    If ((Arg2 == Zero))
                    {
                        Return (Buffer (One)
                        {
                             0x03                                             // .
                        })
                    }

                    Return (Package (0x02)
                    {
                        "plugin-type", 
                        One
                    })
                }
            }
        }

        Method (GPRW, 2, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                If ((0x6D == Arg0))
                {
                    Return (Package (0x02)
                    {
                        0x6D, 
                        Zero
                    })
                }

                If ((0x0D == Arg0))
                {
                    Return (Package (0x02)
                    {
                        0x0D, 
                        Zero
                    })
                }
            }

            Return (XPRW (Arg0, Arg1))
        }
    }
}

