<div id="aluguel-simples">
<!--    <div id="step-aluguel-simples">
        <ul>
            <a id="step-1"><li>1</li></a>
            <a id="step-2"><li>2</li></a>
            <a id="step-3"><li>3</li></a>
        </ul>        
    </div>-->

    <div id="page-aluguel-simples">
        <div id="form">

            <div class="block">
                <div id="label-region">
                    <?php echo form_label('Tipo de Quadra:') ?>
                </div>
                <div id="input-region">
                    <?php echo form_dropdown('tipo_quadra', array(), set_value('tipo_quadra'), 'id="tipo_quadra"') ?>
                </div>
                <div class="clear"></div>
                <div id="label-region">
                    <?php echo form_label('Data da Reserva:') ?>
                </div>
                <div id="input-region">                    
                    <?php echo form_input('data_reserva', date('d/m/Y'), 'id="data_reserva"') ?>
                </div>
                <div class="clear"></div>
                <div id="label-region">
                    <?php echo form_label('Horários:') ?>
                </div>
                <div id="input-region">
                    <?php echo form_dropdown('horarios', array(), set_value('horarios'), 'id="horarios"') ?>
                </div>
                <div class="clear"></div>
                <div id="label-region">
                    <?php echo form_label('Cliente:') ?>
                </div>
                <div id="input-region">
                    <?php echo form_dropdown('cliente', array(), set_value('cliente'), 'id="cliente"') ?>
                </div>
                <div class="clear"></div>              
                <div id="label-region">
                    <?php echo form_label('Quantidade de Horários:') ?>
                </div>
                <div id="input-region">
                    <?php echo form_input('qtde_horarios', '1', 'id="qtde_horarios"') ?>
                </div>
                <div class="clear"></div>              
            </div>

            <div id="page-aluguel-simples-quadras">
                <div id="painel-quadras-livres">
                    <h1>Quadras Disponiveis</h1>
                    <div id="quadraslivres" class="block"></div>
                </div>
                <div id="painel-quadras-reserva">
                    <h1>Quadras Para Reserva</h1>
                    <div id="quadrasreserva" class="block">
                        <table id="quadrasreservatable">
                            <tr>
                                <th></th>
                                <th>Id</th>
                                <th>Descrição</th>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>

            <div id="submit">
                <input id="btnSubmit" type="button" href="" value="Reservar"/>
            </div>
        </div>
    </div>
</div>