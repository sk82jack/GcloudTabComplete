# Add-GcloudToProfile

## SYNOPSIS
Add the import module command to your profile

## SYNTAX

```
Add-GcloudToProfile [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Add the import module command to your profile

It will be added to your current active profile if one is found.
If not it will be added to
the CurrentUserCurrentHost profile

If your current profile is one of the AllUsers profiles but you are not running an elevated
console then an error will be thrown

## EXAMPLES

### EXAMPLE 1
```
Add-GcloudToProfile
```

## PARAMETERS

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://gcloudtabcomplete.readthedocs.io/en/master/functions/Add-GcloudToProfile](https://gcloudtabcomplete.readthedocs.io/en/master/functions/Add-GcloudToProfile)

[https://github.com/sk82jack/GcloudTabComplete/blob/master/GcloudTabComplete/Public/Add-GcloudToProfile.ps1](https://github.com/sk82jack/GcloudTabComplete/blob/master/GcloudTabComplete/Public/Add-GcloudToProfile.ps1)

