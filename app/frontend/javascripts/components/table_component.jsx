'use strict';

import React from 'react';
import {Table} from 'react-bootstrap'

const _ = require('lodash');

const TableComponent = React.createClass({
    propTypes: {
        dogs: React.PropTypes.object
    },

    render() {
        return (
            <div>
                <Table striped>
                    <thead>
                    <tr>
                        <th>Nome</th>
                        <th>Raça</th>
                        <th>Genero</th>
                        <th>Castrado?</th>
                        <th>Idade</th>
                        <th>Dono</th>
                        <th>Telefone</th>
                        <th>Última Visita</th>
                    </tr>
                    </thead>
                    <tbody>
                    {this.renderRows(this.props.dogs, 8)}
                    </tbody>
                </Table>
            </div>
        );
    },

    renderRows(dogs, cols) {
        const no_data = 'Nenhum Registro encontrado.';

        if (!dogs || dogs.length === 0)
            return <tr className="nodata">
                <td style={{textAlign: 'center'}} colSpan={cols}>{no_data}</td>
            </tr>;
        else if (_.isArray(dogs))
            return dogs.map(this.renderRow);
    },

    renderRow(row, i) {
        return (
            <tr key={i}>
                <td>{ row.name }</td>
                <td>{ row.breed_name }</td>
                <td><Gender gender={row.gender_cd}/></td>
                <td>{ <Bool bool={row.castrated}/> }</td>
                <td>{ row.birth_date }</td>
                <td>{ row.owner_name }</td>
                <td>{ row.owner_phone }</td>
                <td>{ row.last_visit }</td>
            </tr>
        );
    }
});

function Gender({gender}) {
    if (gender == 1)
        return <span>Fêmea</span>;
    else
        return <span>Macho</span>;
}

function Bool({bool}) {
    if (bool)
        return <span>Sim</span>;
    else
        return <span>Não</span>;
}

export default TableComponent;