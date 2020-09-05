﻿DECLARE @CurrentMigration [nvarchar](max)

IF object_id('[dbo].[__MigrationHistory]') IS NOT NULL
    SELECT @CurrentMigration =
        (SELECT TOP (1) 
        [Project1].[MigrationId] AS [MigrationId]
        FROM ( SELECT 
        [Extent1].[MigrationId] AS [MigrationId]
        FROM [dbo].[__MigrationHistory] AS [Extent1]
        WHERE [Extent1].[ContextKey] = N'Exercise_1.MovieRentalMigrations.Configuration'
        )  AS [Project1]
        ORDER BY [Project1].[MigrationId] DESC)

IF @CurrentMigration IS NULL
    SET @CurrentMigration = '0'

IF @CurrentMigration < '202006202230179_InitialModel'
BEGIN
    CREATE TABLE [dbo].[Genres] (
        [Id] [int] NOT NULL IDENTITY,
        [Name] [nvarchar](max),
        CONSTRAINT [PK_dbo.Genres] PRIMARY KEY ([Id])
    )
    CREATE TABLE [dbo].[Videos] (
        [Id] [int] NOT NULL IDENTITY,
        [Name] [nvarchar](max),
        [ReleaseDate] [datetime] NOT NULL,
        CONSTRAINT [PK_dbo.Videos] PRIMARY KEY ([Id])
    )
    CREATE TABLE [dbo].[VideoGenres] (
        [Video_Id] [int] NOT NULL,
        [Genre_Id] [int] NOT NULL,
        CONSTRAINT [PK_dbo.VideoGenres] PRIMARY KEY ([Video_Id], [Genre_Id])
    )
    CREATE INDEX [IX_Video_Id] ON [dbo].[VideoGenres]([Video_Id])
    CREATE INDEX [IX_Genre_Id] ON [dbo].[VideoGenres]([Genre_Id])
    ALTER TABLE [dbo].[VideoGenres] ADD CONSTRAINT [FK_dbo.VideoGenres_dbo.Videos_Video_Id] FOREIGN KEY ([Video_Id]) REFERENCES [dbo].[Videos] ([Id]) ON DELETE CASCADE
    ALTER TABLE [dbo].[VideoGenres] ADD CONSTRAINT [FK_dbo.VideoGenres_dbo.Genres_Genre_Id] FOREIGN KEY ([Genre_Id]) REFERENCES [dbo].[Genres] ([Id]) ON DELETE CASCADE
    CREATE TABLE [dbo].[__MigrationHistory] (
        [MigrationId] [nvarchar](150) NOT NULL,
        [ContextKey] [nvarchar](300) NOT NULL,
        [Model] [varbinary](max) NOT NULL,
        [ProductVersion] [nvarchar](32) NOT NULL,
        CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY ([MigrationId], [ContextKey])
    )
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'202006202230179_InitialModel', N'Exercise_1.MovieRentalMigrations.Configuration',  0x1F8B0800000000000400ED59CD6EE33610BE17E83B083AB545D64AB29736B077913A4911749D045112F41630D2D8214A512A4919368A3E590F7DA4BE4287FA172959B2B1488BB60810D824E7FFE37066FCE7EF7F4C3F6E22E6AC41481AF3997B3239761DE0411C52BE9AB9A95ABEFBD6FDF8E1CB2FA69761B4719ECA73EFF539A4E472E6BE2A959C799E0C5E21227212D140C4325EAA4910471E0963EFF4F8F83BEFE4C40364E1222FC799DEA75CD108B22FF8751EF300129512B6884360B258C71D3FE3EADC900864420298B9971B100195F07CE23AE78C12D4C007B6741DC279AC8842FDCE1E25F84AC47CE527B840D8C336013CB7244C42A1F7597D7CAC09C7A7DA04AF262C5905A95471B427C393F7854F3C93FC20CFBA95CFD06B97E85DB5D556679E9BB93F001768B929E96CCE843ED5F4EA243B7BE4D42B4755DC111EFAEFC899A74CA502661C5225083B72EED21746831F61FB10FF0C7CC653C69A1AA14EB8D75AC0A53B112720D4F61E96859ED7A1EB786D3ACF24ACC81A34B911D75CBD3F759D1B144E5E1854016F18ECAB58005A08822808EF885220B8E60199CB2CE9862CFDBF948608C34BE23A0BB2F9047CA55E672E7E749D2BBA81B05C293478E414EF141229918225E486ACE92AD3CF10F7444388A5EBDC03CBB6E52B4D72B84FB2ADE72C5678E04AC4D17DCC4A9262FDF9818815285438EED8F4E35404863253AF86CE4E40659C46022A3BFB3FA0DE10508610840F100917A861294B7F7EA05AB665DC587096D83B149C25FE3AC15922770C38CFA58C039AE9D0446729BF6DCE250F9D5DCAE491A88CC068203269825844C933F71BCB3F3D0CABAB57332C92F04E8653AF618D7D03F1A1548422D80A4317F19AC23D428D30BD051BD57127F1352CAEA52CF0625AA059FBA08CC0D6DE6E1B6039A04D5E262D8BBC70A841DEB0D7E05101A871A40B606616180871A56FADAA37924519D4068B524733C9B4CDEA407115CABAD8F1F26AA7AC8ABC9EB268BA20498299A25126152B8E9FD748F377FEFE454494F3F002D9514B54DA569230EF911518BB281A35BDA2422ACC30E485E884320F23EB5807707B50550A6C61D38E5789B5F2B8FE9C9398A58D495CBBEF0A2D8A50A7CC3830836CD365F5296144743C20F398A511EF7B847651E74F42933E5FB1394C3D4371D32D9EE51703A5A69747C5A0B83507C620CF02FBC7A087EEEF8E411F87D69BDB64D4DA78FB98B6F3524760ABACDB1FBDEA48678C3A2F8BCEA85DC5AD919C6D778C0A6ECEAA2BC4DA1D95E03D752AB2FD813A654CF6D4C97C36EC085AAF8779A4C24FF58A18AFC5B4C8DCC39DB695CAF323AE83BAAFD15198C6FDAD54104DF48189FF0B9B338A88AD0F2C08A74B902AAFE15D6C7A4F8DA6FD9FD3407B52866C4C17FDE65D08D52E1DEC3386EAF81D8D075F1311BC12F15544365F3739D9CDC59E0DE27FDA57A31AB1103FABE1466C3FBF1F0CD41D89D43EDC97E186E3558B6944CDEA5BAE79089B99FB6B4674E65CFFF45CD21D39B702D3CB9973ECFCB677346BB5F7135ED2ED21FCB08EB5F331345B92E156F5C47A836FF905025081731EE459764E644042DB63FA81DA29BDE8044D15C674B87AFA0B4B10FA2E66C5BF54025F32ABCEB91394073421AC65B5FD188FC920DAA48A9FB9730109709D1A6C03C748DB557B54AC0DF70E39A0770A30009CAE8AA5113A3B6A9D01FB9701677C28DF1638BB0AC4CF0E9CEEF191DDAC8F980CF50F86F2FA10DFB4179D9EF2ACD8331FE91C1AF5CF8CBA38770F6FBA39F729DEDCEC95D163C2E0E0AA9A38ED9E5FF5F43E76C2B79AE1C1B955CB6CB3431B3FB21A656C391B1B30B6BBA9B29394357D792B63F798CFD99D14DED0C62F9B9821245DD52CF4EF9C1C82D6DDACCE5CF3655C260943A3F28851C82C40112C1FC9B95074490285DB014899FD86F04458AA3BF7E805C26B7E9BAA24556832442FACF59B844E35BBE46743C8B6CED3DB241BF77F0E13504DAA2BE05BFE7D4A5958E97DD5514BF5B0D039ACA8F5752C95AEF957DB8AD34DCC47322ADC57A5DE07881286CCE42DF7C91A0ED1ED51C2275891605B36C4FD4C8603D176FBF482929520912C78D4F4F815311C469B0F7F010CDE4CA6E01F0000 , N'6.4.4')
END

IF @CurrentMigration < '202006202233144_PopulateTableGenres'
BEGIN
    INSERT INTO Genres VALUES ('Action')
    INSERT INTO Genres VALUES ('Sci-Fi')
    INSERT INTO Genres VALUES ('Comedy')
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'202006202233144_PopulateTableGenres', N'Exercise_1.MovieRentalMigrations.Configuration',  0x1F8B0800000000000400ED59CD6EE33610BE17E83B083AB545D64AB29736B077913A4911749D045112F41630D2D8214A512A4919368A3E590F7DA4BE4287FA172959B2B1488BB60810D824E7FFE37066FCE7EF7F4C3F6E22E6AC41481AF3997B3239761DE0411C52BE9AB9A95ABEFBD6FDF8E1CB2FA69761B4719ECA73EFF539A4E472E6BE2A959C799E0C5E21227212D140C4325EAA4910471E0963EFF4F8F83BEFE4C40364E1222FC799DEA75CD108B22FF8751EF300129512B6884360B258C71D3FE3EADC900864420298B9971B100195F07CE23AE78C12D4C007B6741DC279AC8842FDCE1E25F84AC47CE527B840D8C336013CB7244C42A1F7597D7CAC09C7A7DA04AF262C5905A95471B427C393F7854F3C93FC20CFBA95CFD06B97E85DB5D556679E9BB93F001768B929E96CCE843ED5F4EA243B7BE4D42B4755DC111EFAEFC899A74CA502661C5225083B72EED21746831F61FB10FF0C7CC653C69A1AA14EB8D75AC0A53B112720D4F61E96859ED7A1EB786D3ACF24ACC81A34B911D75CBD3F759D1B144E5E1854016F18ECAB58005A08822808EF885220B8E60199CB2CE9862CFDBF948608C34BE23A0BB2F9047CA55E672E7E749D2BBA81B05C293478E414EF141229918225E486ACE92AD3CF10F7444388A5EBDC03CBB6E52B4D72B84FB2ADE72C5678E04AC4D17DCC4A9262FDF9818815285438EED8F4E35404863253AF86CE4E40659C46022A3BFB3FA0DE10508610840F100917A861294B7F7EA05AB665DC587096D83B149C25FE3AC15922770C38CFA58C039AE9D0446729BF6DCE250F9D5DCAE491A88CC068203269825844C933F71BCB3F3D0CABAB57332C92F04E8653AF618D7D03F1A1548422D80A4317F19AC23D428D30BD051BD57127F1352CAEA52CF0625AA059FBA08CC0D6DE6E1B6039A04D5E262D8BBC70A841DEB0D7E05101A871A40B606616180871A56FADAA37924519D4068B524733C9B4CDEA407115CABAD8F1F26AA7AC8ABC9EB268BA20498299A25126152B8E9FD748F377FEFE454494F3F002D9514B54DA569230EF911518BB281A35BDA2422ACC30E485E884320F23EB5807707B50550A6C61D38E5789B5F2B8FE9C9398A58D495CBBEF0A2D8A50A7CC3830836CD365F5296144743C20F398A511EF7B847651E74F42933E5FB1394C3D4371D32D9EE51703A5A69747C5A0B83507C620CF02FBC7A087EEEF8E411F87D69BDB64D4DA78FB98B6F3524760ABACDB1FBDEA48678C3A2F8BCEA85DC5AD919C6D778C0A6ECEAA2BC4DA1D95E03D752AB2FD813A654CF6D4C97C36EC085AAF8779A4C24FF58A18AFC5B4C8DCC39DB695CAF323AE83BAAFD15198C6FDAD54104DF48189FF0B9B338A88AD0F2C08A74B902AAFE15D6C7A4F8DA6FD9FD3407B52866C4C17FDE65D08D52E1DEC3386EAF81D8D075F1311BC12F15544365F3739D9CDC59E0DE27FDA57A31AB1103FABE1466C3FBF1F0CD41D89D43EDC97E186E3558B6944CDEA5BAE79089B99FB6B4674E65CFFF45CD21D39B702D3CB9973ECFCB677346BB5F7135ED2ED21FCB08EB5F331345B92E156F5C47A836FF905025081731EE459764E644042DB63FA81DA29BDE8044D15C674B87AFA0B4B10FA2E66C5BF54025F32ABCEB91394073421AC65B5FD188FC920DAA48A9FB9730109709D1A6C03C748DB557B54AC0DF70E39A0770A30009CAE8AA5113A3B6A9D01FB9701677C28DF1638BB0AC4CF0E9CEEF191DDAC8F980CF50F86F2FA10DFB4179D9EF2ACD8331FE91C1AF5CF8CBA38770F6FBA39F729DEDCEC95D163C2E0E0AA9A38ED9E5FF5F43E76C2B79AE1C1B955CB6CB3431B3FB21A656C391B1B30B6BBA9B29394357D792B63F798CFD99D14DED0C62F9B9821245DD52CF4EF9C1C82D6DDACCE5CF3655C260943A3F28851C82C40112C1FC9B95074490285DB014899FD86F04458AA3BF7E805C26B7E9BAA24556832442FACF59B844E35BBE46743C8B6CED3DB241BF77F0E13504DAA2BE05BFE7D4A5958E97DD5514BF5B0D039ACA8F5752C95AEF957DB8AD34DCC47322ADC57A5DE07881286CCE42DF7C91A0ED1ED51C2275891605B36C4FD4C8603D176FBF482929520912C78D4F4F815311C469B0F7F010CDE4CA6E01F0000 , N'6.4.4')
END

IF @CurrentMigration < '202006202238599_VideoHasOneGenre'
BEGIN
    IF object_id(N'[dbo].[FK_dbo.VideoGenres_dbo.Videos_Video_Id]', N'F') IS NOT NULL
        ALTER TABLE [dbo].[VideoGenres] DROP CONSTRAINT [FK_dbo.VideoGenres_dbo.Videos_Video_Id]
    IF object_id(N'[dbo].[FK_dbo.VideoGenres_dbo.Genres_Genre_Id]', N'F') IS NOT NULL
        ALTER TABLE [dbo].[VideoGenres] DROP CONSTRAINT [FK_dbo.VideoGenres_dbo.Genres_Genre_Id]
    IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_Video_Id' AND object_id = object_id(N'[dbo].[VideoGenres]', N'U'))
        DROP INDEX [IX_Video_Id] ON [dbo].[VideoGenres]
    IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_Genre_Id' AND object_id = object_id(N'[dbo].[VideoGenres]', N'U'))
        DROP INDEX [IX_Genre_Id] ON [dbo].[VideoGenres]
    ALTER TABLE [dbo].[Videos] ADD [Genre_Id] [int]
    CREATE INDEX [IX_Genre_Id] ON [dbo].[Videos]([Genre_Id])
    ALTER TABLE [dbo].[Videos] ADD CONSTRAINT [FK_dbo.Videos_dbo.Genres_Genre_Id] FOREIGN KEY ([Genre_Id]) REFERENCES [dbo].[Genres] ([Id])
    DROP TABLE [dbo].[VideoGenres]
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'202006202238599_VideoHasOneGenre', N'Exercise_1.MovieRentalMigrations.Configuration',  0x1F8B0800000000000400ED59DD6EE34414BE47E21D2C5F01EAC669F706A26457256D51C4A6ADEAB6E2AE9AD827E988F1D8CC8CA3448827E38247E21538E37FCF388913B1050954A94A67CEFFF9E6FCA47FFEFEC7F8E32662CE1A84A4319FB8E783A1EB000FE290F2D5C44DD5F2DDB7EEC70F5F7E31BE0EA38DF35CD2BDD774C8C9E5C47D552A19799E0C5E21227210D140C4325EAA4110471E0963EF6238FCCE3B3FF70045B828CB71C60F29573482EC0FFC731AF300129512368F4360B238C71B3F93EADC920864420298B8D71B100195F072EE3A978C12B4C007B6741DC279AC8842FB464F127C2562BEF2133C20EC719B00D22D099350D83DAAC9FBBA30BCD02E783563292A48A58AA323059EBF2F62E299EC2745D6AD628651BBC6E8AAADF63A8BDCC4FD01B840CF4D4DA329139AAA19D541467BE6D4276755DE111EFAE7CC99A64CA502261C5225083B73EED305A3C18FB07D8C7F063EE129634D8BD026BC6B1DE0D1BD8813106AFB00CBC2CE59E83A5E9BCF33192BB6064FEEC48CABF717AE738BCAC9824195F086C3BE8A05A087208882F09E2805826B199085CCD26EE8D2BF4B6D88307C24AE33279B4FC057EA75E2E247D7B9A11B08CB93C282274EF14D21931229584A6EC99AAE32FB0C75CF348458BACE03B0EC5ABED22487FB20BB7A29F27A23E2E8216625477EFCF248C40A149A1BDB777E9C8AC0B064ECD5B8D98BA64C504F3465B4FFA3E90DD1642841EC009170851696BAF4E747AA755BCEF5456601BCD3805982AF0B982568FB00F352CA38A099014D6416CADB9E5CF3D0D963499E83CA7ECC036292268842D43B71BFB122D32DAF7A72B5BC22126D79C3C1E0DCF4B1E18DFDFAB0432A42116885A3F3784DE101614698BE828DEA788FD8068B27290BAC983E68D13EA86652B1DCD4D16EFB6085A0CD5E562B8BBD08A9C1DEF0D79051A2A741D1012EF3FDEFCF70656C6DA7D74F4299D386843250667169BBD481E02A8DF584E3E5234E390A793B66A1F19C24095688C66C549C387E3E184DDFF9C74F0E512EC30B64C70051595B69C27A475660DCA26AB4F4860AA9B0B29005D185641A46165907687720AA54D8C2A59DAE126725B9FE9CB398F38CC95C87EF063D8AD0A6CC3930936CF3654329614474348E69CCD288EF6A3EFBB8F356D0E4CF4F6C0963CF30DC0C8B67C5C540A919E55E39281ECD8939C82BC0F139D8C1F74FE760978456AF6D0A6A5DBC7D4EDB75A923B165C5DD9DBC92A257867425ED1A65DB15D50E43AFA4E632BA52ABC350E93DCEA4A24D9C68D2D1C660F90B6936B7CCA49EC1AAF9AB8FA3669FB1536EB51B93A4025CD5768CF6322E4AFDE17DDCAAFD3989EBA0EF6B8C30D67D7F2B1544034D30F07F61534611E235C19C70BA04A9F261DFC5D5F8C258EDFF3D6BB62765C8FAECDA6FBEAE501DD2830BC9A1817FCF86C2D74404AF447C1591CDD74D49F61672E426F99F8E55AF8D2DC4CFAAD7C6D6B5A7BD189E5B8BC28C87B099B8BF664C2367F6D34BC977E6DC097CA22367E8FC765ACE4F5BD21AFDE8B83DCA1EE34FD9EE106820340EB249552A8155D46ACAF7B8B1073421AC65B3DD42FAA057C7AF9267DE5C41025CC3B2E5561F45FB7A6525D57846877C3F7253B577831E4BE8EE1D34EF2EF822163AB1391877AC639DFBE9EEF5B44B72F7AAF81957D796F78D35E4E0B26A6FB89F673DB5E702444CE3DB7C04ABA4AB5A841E7538042DAC543433BE8C4BD01A169524463D9B8322580CC9A55074490285D70148997D75F64C58AA27D76801E18CDFA52A4915BA0CD182B5BE8AD3D0DFA73FDBC1DB368FEF92EC6BAEBFC3053493EA7A7EC7BF4F290B2BBB6FEC7ABE4B847E5345E7D2B954BA83ADB695A4DB98F7145484AF2A058F10250C85C93BEE93359C62DB93844FB022C1B61CEF760B399C8876D8C75794AC04896421A3E6D7FFA1F2F4BFA83EFC05FAE1C147D41A0000 , N'6.4.4')
END

IF @CurrentMigration < '202006202246236_AddColumnClassificationToTableVideo'
BEGIN
    ALTER TABLE [dbo].[Videos] ADD [Classification] [int] NOT NULL DEFAULT 0
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'202006202246236_AddColumnClassificationToTableVideo', N'Exercise_1.MovieRentalMigrations.Configuration',  0x1F8B0800000000000400ED59CD6EE33610BE17E83B083AB545D6B2934B1BD8BB489D6461749D045112F416D0D2D8214A512A4919368A3E590F7DA4BE4287FA17293BB291DD1668B1C0C2226786F3F3717E98BFFEF873FC611331670D42D2984FDCD160E83AC08338A47C357153B57CF7BDFBE1FDD75F8DAFC268E33C9574679A0E39B99CB82F4A25E79E27831788881C443410B18C976A10C49147C2D83B1D0E7FF046230F50848BB21C677C9F724523C83EF0731AF300129512368F4360B258C71D3F93EADC900864420298B8571B100195F03C729D0B46096AE0035BBA0EE13C5644A17EE78F127C2562BEF2135C20EC619B00D22D099350E87D5E93F7356178AA4DF06AC65254904A1547070A1C9D153EF14CF6A33CEB563E43AF5DA177D5565B9D796EE27E042ED072F3A4F329139AAAE9D541467BE2D42B2755DC111EFADF89334D994A054C38A44A1076E2DCA50B46839F60FB10FF027CC253C69A1AA14EB8D75AC0A53B112720D4F61E96859EB3D075BC369F6732566C0D9EDC88195767A7AE7383879305832AE00D837D150B400B411005E11D510A04D73220739975BA7196FEBF3C0D118697C475E664F309F84ABD4C5CFCE93AD7740361B95268F0C829DE2964522205EB901BB2A6AB4C3FE3B8271A422C5DE71E58B62D5F6892C37D906D3D1771BD1671741FB392235F7E7E2062050AD58DED3D3F4E45606832F66ADCEC455326A8279A32DAFFD1F405D1641C82D80122E112352CCFD2BF1FA83EDB326EBFAC292352D2250D8A3C55A8AEF1686EBD267927E60B481F07F912D65D902FAF433FC8A75103F0A6713379CDC8AAAE28BD6E425BC85B5C09044208826D11384DC8B61D3D876801A230C4A70C6BBDEB3C1196E2E7C80A4B8BFA63CCC28AF6743FED9D0E177AADA23FB33D9DFBB4B97821651CD0CC21CDDC5204B97DDC150F9D3D11AFA158A4A739BA9026E8348CEFC4FDCE52BF5B5E95346B7905E2DAF28683C1C8B4B0618D9D3FB1C75184F2CA61F3784DE11E1305617A0B36AA0347D8C8145092C56D376DD0A27D50CDCB8305A34675DB06CB056DF6B2DE58EC854B0DF686BD868CF29636283A2EB199C1F747B852B6D6D3EB27A18C694342E928B33CB44DEAC8145518EB1ED5CB9BD4B299F57674B3E3394912BCAA8DEEB65871FCBCB59DBEF30FEFFDA25C8617C88E16B0D2B63A092B165981B18B47A3A6D7544885B5812C884E6AD330B2C83A40BB0351E5812D5CDAE12A715692EBDF398BD9919ACCB5FBAED1A20875CA8C0333C8365F365610464447E99FC62C8DF8AEF6611F775ECC9BFCF98A2D61EC198A9B6EF12CBF182835BDDC2B06C5A53932067906383C063BF8FEE918EC92D0EA969A825A1BFDE5999D4353A4B9F7E591D2CE761D7029F3F86E489414BDE2AEF373D788D3CED3B61B7A412597D10518ED86EADCC3542A8ACF912A1DAC0C26D59066DDD04CEA0EBAEA30FB186A562F3BE4561133492AC055C5CC285AE3A280BCFE4E6355949CC475D0F6357A18AB89BF950AA2812618F8BFB229A308F19A604E385D825479C7EB9E0E47A7C693CFBFE7F9C59332647DDE60BEF8184BB54B5F1D540F1C049B932B5F1311BC10F14D4436DF3625D9D3E9812F0CFF695FF59AE443FCADDE6E92CFEC3F50529D8D1A32AC41668693EA66E2FE96319D3BB39F9F4BBE13E756E0653F7786CEEFC7A1E7B821B251D90E9BF3EC31E398E913210B42232AEBA4250EF9D42EEF7782F2802684B574B68B519F7BA0FD57C933772E2101AE01DE32ABCF41FBAA6E25D5B890AFD97EE0246DCF2E3D86E4DD33725EA7F06E2D74607330EE18173BE7E7DDE37397E4EE51F6338ED62DEB1B63D2ABC3B43D817F9EF1D9EE3010318DBF172158255DD52274D3C4216861A5A299F1655C82D6D0A82431F2D91C14C1B44A2E84A24B1228DC0E0073A57E9C2D9EB6AEA20584337E9BAA24556832440BD67AECD5D0DF777EF646D0D6797C9B64CF9D6F6102AA497565B8E53FA6B4F184776DE7F35D22F49D2A6AA08EA5D2B570B5AD24DDC4BCA7A0C27D552A78802861284CDE729FACE118DD1E257C821509B665A3B85BC8EB8168BB7D7C49C94A904816326A7EFC440C87D1E6FDDF442517A6361D0000 , N'6.4.4')
END
